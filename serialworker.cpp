#include "serialworker.h"
#include <QTimer>
#include <QEventLoop>
#include <QThread>
#include <QDebug>

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
    int maxdataLength = 50;   // Be carefull if big frames are sent



    // Serial Port Initialization
    m_Serial = new QSerialPort();

    m_Serial->setPortName("ttyS0");
    //m_Serial->setPortName("ttyUSB0");
    m_Serial->setBaudRate(QSerialPort::Baud115200);
    m_Serial->setDataBits(QSerialPort::Data8);
    m_Serial->setParity(QSerialPort::NoParity);
    m_Serial->setStopBits(QSerialPort::OneStop);
    m_Serial->setFlowControl(QSerialPort::NoFlowControl);
    m_Serial->open(QIODevice::ReadWrite);
    qDebug() << "SerialPort Status: " << m_Serial->isOpen();
    emit serialConnected(m_Serial->isReadable());


    while(!abort)
    {
        QThread::msleep(5);
        //qDebug() << "Bytes availiable?: " << m_Serial->isReadable();
        while (!isConected(m_Serial)){
            //emit serialConnected(false);
            QThread::sleep(1);
            qDebug() << "Serial Error: " << m_Serial->error();
            qDebug() << "Is readable?: " << m_Serial->isReadable();
            qDebug() << "Bytes availiable?: " << m_Serial->bytesAvailable();
            mutex.lock();
            abort = _abort;
            mutex.unlock();
        }

        while (isConected(m_Serial)) {

            //emit serialConnected(true);
            mutex.lock();
            abort = _abort;
            mutex.unlock();
            //emit serialConnected(m_Serial->isReadable());

            if(!m_outFrameQueue->isEmpty())
            {
                //qDebug() << "Frame empty";
                Frame *outFrame = m_outFrameQueue->dequeue();
                sendFrame(outFrame);
                delete outFrame;

            } else
            {
                if (m_Serial->waitForReadyRead(20) )
                {
                    QByteArray receivedData;
                    //receivedData.resize(50);
                    receivedData = m_Serial->readAll();
                    //qDebug() << "receivedData" << receivedData;
                    //qDebug() << "receivedData.count" << receivedData.count();

                    while(receivedData.count() > 0 && receivedData.count() < maxdataLength )
                    {
                        //qDebug() << "Counting data";
                        inByte = quint8(receivedData[0]);
                        receivedData.remove(0,1);

                        if(inByte == Frame::FRAME_ESCAPE_CHAR)
                        {
                            xored = Frame::FRAME_XOR_CHAR;
                            //qDebug() << "Escape char";
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
                                    if (m_inFrame == nullptr)
                                        m_inFrame = new Frame();
                                    else
                                        m_inFrame->Clear();
                                    m_inFrame->AddByte(inByte);
                                    checksum = inByte;
                                    receiverStatus = RCV_ST_CMD;
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
                                if (dataLength > 2) {receiverStatus = RCV_ST_IDLE; break;} //TODO!
                            } break;

                            case RCV_ST_DATA:
                            {
                                m_inFrame->AddByte(inByte);
                                checksum += inByte;
                                if (--numByte == 0)
                                    receiverStatus = RCV_ST_CHECKSUM;
                                else if (numByte < 0)
                                    receiverStatus = RCV_ST_IDLE;
                            } break;

                            case RCV_ST_CHECKSUM:
                            {
                                if (inByte == checksum)
                                {
                                    receiverStatus = RCV_ST_IDLE;
                                    m_inFrame->AddByte(checksum);
                                    emit this->frameReceived(m_inFrame);
                                }
                                else
                                {
                                    receiverStatus = RCV_ST_IDLE;
                                    m_inFrame->Clear();
                                    delete m_inFrame;
                                }
                            } break;
                            }
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
    QByteArray outBuffer;
    outBuffer.resize(frameLength);  //Is it the right lenght?
    QByteArray frameBuffer = frame->GetBuffer();

    outBuffer[dataToSend++] = Frame::FRAME_START;

    quint8 value;

    for(int i = 1; i < frameLength; i++)
    {
        value = frameBuffer[i];
        if(value == Frame::FRAME_START || value == Frame::FRAME_ESCAPE_CHAR)
        {
            //qDebug() << "SPECIAL CHAR: " << value << " - AT INDEX: " << i;
            outBuffer[dataToSend++] = Frame::FRAME_ESCAPE_CHAR;
            outBuffer[dataToSend++] = value ^ Frame::FRAME_XOR_CHAR;
        } else
            outBuffer[dataToSend++] = value;
    }
    //qDebug() << "Frame sent: " << outBuffer;
    m_Serial->write(outBuffer);
}

bool SerialWorker::isConected(QSerialPort *m_Serial){
//    qDebug() << "SerialPort Error: " << m_Serial->error();
//    qDebug() << "SerialPort isReadable:  " << m_Serial->isReadable();
//    qDebug() << "SerialPort isReadable:  " << m_Serial->bytesAvailable();
    if (m_Serial->error() == QSerialPort::SerialPortError::NoError){
        return true;
    }  else {
        //m_Serial->reset();
        m_Serial->close();
        m_Serial->clearError();
        m_Serial->open(QIODevice::ReadWrite);
        return  false;
    }
}

