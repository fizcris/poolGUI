#ifndef FRAMEPROCESSOR_H
#define FRAMEPROCESSOR_H

#include <QObject>
#include "frame.h"
#include "serialworker.h"
#include <QQueue>

class FrameProcessor : public QObject
{
    // Check that these are the same as the MCU
    static const quint8 CMD_STATE_STOP = 1;
    static const quint8 CMD_STATE_POOL = 2;
    static const quint8 CMD_STATE_FLOOR = 3;
    static const quint8 CMD_STATE_HOT_SERIES = 4;
    static const quint8 CMD_STATE_HOT_PARALELL = 5;
    static const quint8 CMD_STATE_COLD_SEERIES = 6;
    static const quint8 CMD_STATE_COLD_PARALELL = 7;
    static const quint8 CMD_STATE_EMERGENCE = 8;
    static const quint8 TEMP_POOL = 100;
    static const quint8 TEMP_FLOOR = 101;
    static const quint8 TEMP_HEATER = 102;
    static const quint8 TEMP_POOL_IMP = 103;
    static const quint8 TEMP_FLOOR_IMP = 104;
    static const quint8 TEMP_RETURN = 105;
    static const quint8 TEMP_SERIES = 106;
    static const quint8 PRESS_RETURN = 107;
    static const quint8 HG_RETURN = 108;

    Q_OBJECT
public:
    explicit FrameProcessor(QQueue<Frame*> *outFrameQueue, QObject *parent = nullptr);

private:
    SerialWorker *m_serialWorker;
    QQueue<Frame*> *m_outFrameQueue;

signals:
    void changedInput100(int _value);
    void changedInput101(int _value);
    void changedInput102(int _value);
    void changedInput103(int _value);
    void changedInput104(int _value);
    void changedInput105(int _value);
    void changedInput106(int _value);
    void changedInput107(int _value);
    void changedInput108(int _value);

public slots:
    void FrameIncoming(Frame *frame);

    //void setPwm(quint8 color, quint8 value);
    //void enableAdc(quint8 enable);
};

#endif // FRAMEPROCESSOR_H
