#include "serialworker.h"
#include <QTimer>
#include <QEventLoop>
#include <QThread>
#include <QDebug>
#include <QDateTime>


SerialWorker::SerialWorker(QQueue<Frame*> *outFrameQueue, QObject *parent) :
    QObject(parent)
{
    _working =false;
    _abort = false;
    m_Serial = nullptr;
    m_outFrameQueue = outFrameQueue;
}

SerialWorker::~SerialWorker()
{
    if(m_Serial != nullptr)
        delete m_Serial;
}

void SerialWorker::requestWork()
{
    mutex.lock();
    _working = true;
    _abort = false;
    qDebug()<<"Request worker start in Thread "<<thread()->currentThreadId();
    mutex.unlock();

    emit workRequested();
}

void SerialWorker::abort()
{
    mutex.lock();
    if (_working) {
        _abort = true;
        qDebug()<<"Request worker aborting in Thread "<<thread()->currentThreadId();
    }
    mutex.unlock();
}

void SerialWorker::doWork()
{
    qDebug()<<"Starting worker process in Thread "<<thread()->currentThreadId();

    bool abort = false;
    quint8 inByte;
    int numByte = 0;
    int receiverStatus = RCV_ST_IDLE;
    Frame *m_inFrame = nullptr;
    quint8 checksum = 0, xored = 0x00;
    int dataLength = 0;
    // For WD
    bool isSerialConected = false;
    QDateTime startTime = QDateTime::currentDateTime();
    qint16 secondsDiff = 0;
    qint16 timeoutSeconds = 1;

    // Serial Port Initialization
    m_Serial = new QSerialPort();
    m_Serial->setPortName("ttyS0");
    //m_Serial->setPortName("ttyUSB0");
    m_Serial->setBaudRate(QSerialPort::Baud9600);
    m_Serial->setDataBits(QSerialPort::Data8);
    m_Serial->setParity(QSerialPort::NoParity);
    m_Serial->setStopBits(QSerialPort::OneStop);
    m_Serial->setFlowControl(QSerialPort::NoFlowControl);
    m_Serial->open(QIODevice::ReadWrite);
    qDebug() << "SerialPort Status: " << m_Serial->isOpen();

    while(!abort)
    {
        //QThread::msleep(5);
//        qDebug() << "isSerialConected:" << isSerialConected;
        if (_isSerialconnected != isSerialConected){
            _isSerialconnected = isSerialConected;
            emit this->serialConnected(_isSerialconnected);
            }

        secondsDiff = startTime.secsTo(QDateTime::currentDateTime());
//        qDebug() << "Watchdog Time:" << secondsDiff;
        if (secondsDiff >= timeoutSeconds){
            isSerialConected = false;
//            //QThread::sleep(1);
            startTime = QDateTime::currentDateTime(); //Reset Wd
//            //mutex.lock();
//            //abort = _abort;
//            //mutex.unlock();
        };

        mutex.lock();
        abort = _abort;
        mutex.unlock();

        if(!m_outFrameQueue->isEmpty())
        {
            Frame *outFrame = m_outFrameQueue->dequeue();
            sendFrame(outFrame);
            delete outFrame;


        } else
        {
            if (m_Serial->waitForReadyRead(10) )
            {
                QByteArray receivedData = m_Serial->readAll();

                while(receivedData.count() > 0)
                {
                    inByte = quint8(receivedData[0]);
                    receivedData.remove(0,1);

                    if(inByte == Frame::FRAME_ESCAPE_CHAR)
                    {
                        xored = Frame::FRAME_XOR_CHAR;
                    } else
                    {
                        inByte ^= xored;
                        xored = 0x00;

                        switch (receiverStatus)
                        {
                        case RCV_ST_IDLE:
                        {
                            if(inByte == Frame::FRAME_START)
                            {
                                m_inFrame = new Frame();
                                m_inFrame->AddByte(inByte);
                                checksum = inByte;
                                receiverStatus = RCV_ST_CMD;
                                dataLength = 0;
                            }
                        } break;

                        case RCV_ST_CMD:
                        {
                            m_inFrame->AddByte(inByte);
                            checksum += inByte;
                            receiverStatus = RCV_ST_DATA_LENGTH;
                        } break;

                        case RCV_ST_DATA_LENGTH:
                        {
                            numByte = dataLength = inByte;
                            m_inFrame->AddByte(inByte);
                            checksum += inByte;
                            receiverStatus = RCV_ST_DATA;
                        } break;

                        case RCV_ST_DATA:
                        {
                            m_inFrame->AddByte(inByte);
                            checksum += inByte;
                            numByte--;
                            if (numByte == 0)
                                receiverStatus = RCV_ST_CHECKSUM;
                            else if (numByte < 0){
                                receiverStatus = RCV_ST_IDLE;
                                delete m_inFrame;
                            }

                        } break;

                        case RCV_ST_CHECKSUM:
                        {

                            //qDebug() << "Frame should be" << dataLength + m_inFrame->FRAME_NUM_EXTRA_BYTES -1;
                            //qDebug() << "Frame is" <<   m_inFrame->GetBufferLength();
                            if (inByte == checksum && m_inFrame->GetBufferLength() == (dataLength + m_inFrame->FRAME_NUM_EXTRA_BYTES -1))
                            {
                                receiverStatus = RCV_ST_IDLE;
                                m_inFrame->AddByte(checksum);
                                emit this->frameReceived(m_inFrame);
                                //Reset watchdog
                                isSerialConected = true;
                                startTime = QDateTime::currentDateTime();
                            }
                            else
                            {
                                delete m_inFrame;
                                receiverStatus = RCV_ST_IDLE;
                            }
                        } break;
                        }
                    }
                }
            }

        }
    }

    if(m_Serial != nullptr)
    {
        m_Serial->close();
        qDebug() << "SerialPort Closed";
        delete m_Serial;
        qDebug() << "SerialPort destroyed";
    }

    // Set _working to false, meaning the process can't be aborted anymore.
    mutex.lock();
    _working = false;
    mutex.unlock();

    qDebug()<<"Worker process finished in Thread "<<thread()->currentThreadId();

    emit finished();
}


void SerialWorker::sendUint8(quint8 cmd, quint8 data)
{
    if(m_Serial != nullptr && m_Serial->isOpen())
    {
        Frame frameToSend(cmd, data);
        sendData(&frameToSend);
    }
}

void SerialWorker::sendUint16(quint8 cmd, quint16 data)
{
    if(m_Serial != nullptr && m_Serial->isOpen())
    {
        Frame frameToSend(cmd, data);
        sendData(&frameToSend);
    }
}

void SerialWorker::sendUint32(quint8 cmd, quint32 data)
{
    if(m_Serial != nullptr && m_Serial->isOpen())
    {
        Frame frameToSend(cmd, data);
        sendData(&frameToSend);
    }
}

void SerialWorker::sendFrame(Frame *frame)
{
    if(m_Serial != nullptr && m_Serial->isOpen() && frame != nullptr)
    {
        sendData(frame);

    }
}

quint8 SerialWorker::calculateChecksum(QByteArray buffer)
{
    quint8 rv = 0;
    for (int i = 0; i < buffer.count(); i++)
        rv += quint8(buffer[i]);
    return rv;
}

void SerialWorker::sendData(Frame *frame)
{
    int dataToSend = 0;
    int frameLength = frame->GetDataLength() + Frame::FRAME_NUM_EXTRA_BYTES;
    if (frame->GetDataLength() > 0){
        QByteArray outBuffer;
        outBuffer.resize(frameLength);
        QByteArray frameBuffer = frame->GetBuffer();

        quint8 value;

        outBuffer[dataToSend++] = Frame::FRAME_START;
        for(int i = 1; i < frameLength; i++)
        {
            value = frameBuffer.at(i);
            if(value == Frame::FRAME_START || value == Frame::FRAME_ESCAPE_CHAR)
            {
                //qDebug() << "SPECIAL CHAR: " << value << " - AT INDEX: " << i;
                outBuffer[dataToSend++]= Frame::FRAME_ESCAPE_CHAR;
                outBuffer[dataToSend++] = value ^ Frame::FRAME_XOR_CHAR;
            } else
                outBuffer[dataToSend++] = value;
        }

        m_Serial->write(outBuffer);
    }
}
