#include "frameprocessor.h"

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
        case TEMP_POOL:
        {
            emit changedInput100(frame->GetUByte());
        } break;

        case TEMP_FLOOR:
        {
            emit changedInput101(frame->GetUByte());
        } break;

        case TEMP_HEATER:
        {
            emit changedInput102(frame->GetUByte());
        } break;
        case TEMP_POOL_IMP:
        {
            emit changedInput103(frame->GetUByte());
        } break;
        case TEMP_FLOOR_IMP:
        {
            emit changedInput104(frame->GetUByte());
        } break;
        case TEMP_RETURN:
        {
            emit changedInput105(frame->GetUByte());
        } break;
        case TEMP_SERIES:
        {
            emit changedInput106(frame->GetUByte());
        } break;
        case PRESS_RETURN:
        {
            emit changedInput107(frame->GetUByte());
        } break;
        case HG_RETURN:
        {
            emit changedInput108(frame->GetUByte());
        } break;
        }

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
