#ifndef FRAMEPROCESSOR_H
#define FRAMEPROCESSOR_H

#include <QObject>
#include "frame.h"
#include "serialworker.h"
#include <QQueue>

class FrameProcessor : public QObject
{
    // Check that these are the same as the MCU
    // Rpi -> MCU
    static const quint8 CMD_STATE_STOP = 1;
    static const quint8 CMD_STATE_POOL = 2;
    static const quint8 CMD_STATE_FLOOR = 3;
    static const quint8 CMD_STATE_HOT_SERIES = 4;
    static const quint8 CMD_STATE_HOT_PARALELL = 5;
    static const quint8 CMD_STATE_COLD_SERIES = 6;
    static const quint8 CMD_STATE_COLD_PARALELL = 7;
    static const quint8 CMD_STATE_EMERGENCE = 8;
    static const quint8 CMD_TEMP_POOL = 9;
    static const quint8 CMD_TEMP_FLOOR = 10;
    // MCU -> Rpi
    static const quint8 TEMP_POOL = 100;
    static const quint8 TEMP_FLOOR = 101;
    static const quint8 TEMP_HEATER = 102;
    static const quint8 TEMP_POOL_IMP = 103;
    static const quint8 TEMP_FLOOR_IMP = 104;
    static const quint8 TEMP_RETURN = 105;
    static const quint8 TEMP_SERIES = 106;

    static const quint8 PRESS_RETURN = 107;
    static const quint8 HG_RETURN = 108;

    static const quint8 STATE_VK_1 = 109;
    static const quint8 STATE_VK_2 = 110;
    static const quint8 STATE_VK_3 = 111;
    static const quint8 STATE_VK_4 = 112;
    static const quint8 STATE_PUMP_POOL_IMP = 113;
    static const quint8 STATE_PUMP_POOL = 114;
    static const quint8 STATE_PUMP_FLOOR = 115;

    static const quint8 DESIRED_TEPM_POOL = 116;
    static const quint8 DESIRED_TEMP_FLOOR = 117;
    static const quint8 DESIRED_STATE = 118;

    Q_OBJECT
public:
    explicit FrameProcessor(QQueue<Frame*> *outFrameQueue, QObject *parent = nullptr);

private:
    SerialWorker *m_serialWorker;
    QQueue<Frame*> *m_outFrameQueue;

signals:
    void changedInput8(int _value);
    void changedInput100(int _value);
    void changedInput101(int _value);
    void changedInput102(int _value);
    void changedInput103(int _value);
    void changedInput104(int _value);
    void changedInput105(int _value);
    void changedInput106(int _value);
    void changedInput107(int _value);
    void changedInput108(int _value);
    void changedInput109(int _value);
    void changedInput110(int _value);
    void changedInput111(int _value);
    void changedInput112(int _value);
    void changedInput113(int _value);
    void changedInput114(int _value);
    void changedInput115(int _value);
    void changedInput116(int _value);
    void changedInput117(int _value);
    void changedInput118(int _value);


public slots:
    void FrameIncoming(Frame *frame);
    void sendStateStop(quint8 enable);
    void sendStatePool(quint8 enable);
    void sendStateFloor(quint8 enable);
    void sendStateHotSeries(quint8 enable);
    void sendStateHotParalell(quint8 enable);
    void sendStateColdSeries(quint8 enable);
    void sendStateColdParalell(quint8 enable);
//    void sendStateEmergence(quint8 enable);

    void sendTemperaturePool(quint16 temp);
    void sendTemperatureFloor(quint16 temp);

};

#endif // FRAMEPROCESSOR_H
