#include "frameprocessor.h"
#include <QDebug>

FrameProcessor::FrameProcessor(QQueue<Frame*> *outFrameQueue, QObject *parent) : QObject(parent)
{
    m_outFrameQueue = outFrameQueue;
}

void FrameProcessor::FrameIncoming(Frame *frame)
{
    if (frame != nullptr)
    {
        quint8 cmd = frame->GetCmd();

        switch (cmd)
        {
        case CMD_STATE_EMERGENCE:
        {
            emit changedInput8(frame->GetUInt16());
        } break;
        case TEMP_POOL:
        {
            emit changedInput100(frame->GetUInt16());
            //qDebug() << "Received:" << frame->GetUInt16();
        } break;

        case TEMP_FLOOR:
        {
            emit changedInput101(frame->GetUInt16());
        } break;

        case TEMP_HEATER:
        {
            emit changedInput102(frame->GetUInt16());
        } break;
        case TEMP_POOL_IMP:
        {
            emit changedInput103(frame->GetUInt16());
        } break;
        case TEMP_FLOOR_IMP:
        {
            emit changedInput104(frame->GetUInt16());
        } break;
        case TEMP_RETURN:
        {
            emit changedInput105(frame->GetUInt16());
        } break;
        case TEMP_SERIES:
        {
            emit changedInput106(frame->GetUInt16());
        } break;
        case PRESS_RETURN:
        {
            emit changedInput107(frame->GetUInt16());
        } break;
        case HG_RETURN:
        {
            emit changedInput108(frame->GetUInt16());
        } break;
        case STATE_VK_1:
        {
            emit changedInput109(frame->GetUInt16());
        } break;
        case STATE_VK_2:
        {
            emit changedInput110(frame->GetUInt16());
        } break;
        case STATE_VK_3:
        {
            emit changedInput111(frame->GetUInt16());
        } break;
        case STATE_VK_4:
        {
            emit changedInput112(frame->GetUInt16());
        } break;
        case STATE_PUMP_POOL_IMP:
        {
            emit changedInput113(frame->GetUInt16());
        } break;
        case STATE_PUMP_POOL:
        {
            emit changedInput114(frame->GetUInt16());
        } break;
        case STATE_PUMP_FLOOR:
        {
            emit changedInput115(frame->GetUInt16());
        } break;
        case DESIRED_TEPM_POOL:
        {
            emit changedInput116(frame->GetUInt16());
        } break;
        case DESIRED_TEMP_FLOOR:
        {
            emit changedInput117(frame->GetUInt16());
        } break;
        case DESIRED_STATE:
        {
            emit changedInput118(frame->GetUInt16());
        } break;
        }

        frame->deleteLater();

    }
}

//void FrameProcessor::setPwm(quint8 color, quint8 value)
//{
//    Frame *frameToSend = new Frame(color, value);
//    m_outFrameQueue->enqueue(frameToSend);
//}

//void FrameProcessor::enableAdc(quint8 enable)
//{
//    Frame *frameToSend = new Frame(CMD_ADC_ENABLE, enable);
//    m_outFrameQueue->enqueue(frameToSend);
//}

void FrameProcessor::sendStateStop(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_STOP, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
void FrameProcessor::sendStatePool(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_POOL, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
void FrameProcessor::sendStateFloor(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_FLOOR, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
void FrameProcessor::sendStateHotSeries(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_HOT_SERIES, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
void FrameProcessor::sendStateHotParalell(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_HOT_PARALELL, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
void FrameProcessor::sendStateColdSeries(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_COLD_SERIES, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
void FrameProcessor::sendStateColdParalell(quint8 enable)
{
    Frame *frameToSend = new Frame(CMD_STATE_COLD_PARALELL, enable);
    m_outFrameQueue->enqueue(frameToSend);
}
//void FrameProcessor::sendStateEmergence(quint8 enable)
//{
//    //TODO
//    Frame *frameToSend = new Frame(CMD_STATE_EMERGENCE, enable);
//    m_outFrameQueue->enqueue(frameToSend);
//}

void FrameProcessor::sendTemperaturePool(quint16 temp)
{
    Frame *frameToSend = new Frame(CMD_TEMP_POOL, temp);
    m_outFrameQueue->enqueue(frameToSend);
    //qDebug() << "Temp to send: " << temp;
}

void FrameProcessor::sendTemperatureFloor(quint16 temp)
{
    Frame *frameToSend = new Frame(CMD_TEMP_FLOOR, temp);
    //qDebug() << "Temp to send: " << temp;
    m_outFrameQueue->enqueue(frameToSend);
}
