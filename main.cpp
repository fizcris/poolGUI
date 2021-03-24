#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtDebug>
#include <QThread>
#include <QQueue>
#include <QQmlContext>
#include "frame.h"
#include "serialworker.h"
#include "frameprocessor.h"

int main(int argc, char *argv[])
{
    int rv;
    qDebug() << "Hello world";

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // Import QQue to send frames
    QQueue<Frame*> outFrameQueue;

    // Start serialWorker in a separated thread
    QThread *threadSerial = new QThread();
    SerialWorker *serialWorker = new SerialWorker(&outFrameQueue);
    FrameProcessor *frameProcessor = new FrameProcessor(&outFrameQueue);

    // Obtain context (root)
    QQmlApplicationEngine engine;
    QQmlContext* ctx = engine.rootContext();
    // Set property serial
    ctx->setContextProperty("serial", frameProcessor);
    //ctx->setContextProperty("serialWorker", serialWorker);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    // Move serial worker to a separated frame
    serialWorker->moveToThread(threadSerial);
    //Define SIGNALS and SLOTS
    QObject::connect(serialWorker, SIGNAL(serialConnected(bool)), frameProcessor, SLOT(serialConnectedSlot(bool)),Qt::QueuedConnection);
    QObject::connect(serialWorker, SIGNAL(frameReceived(Frame*)), frameProcessor, SLOT(FrameIncoming(Frame*)));
    QObject::connect(serialWorker, SIGNAL(workRequested()), threadSerial, SLOT(start()));
    QObject::connect(threadSerial, SIGNAL(started()), serialWorker, SLOT(doWork()),Qt::DirectConnection);
    QObject::connect(serialWorker, SIGNAL(finished()), threadSerial, SLOT(quit()), Qt::DirectConnection);

    // End Serial thread
    serialWorker->abort();
    threadSerial->wait(); // If the thread is not running, this will immediately return.
    serialWorker->requestWork();

    rv = app.exec();
    serialWorker->abort();
    threadSerial->wait();
    delete threadSerial;
    qDebug() << "Delete Serial Thread";
    delete serialWorker;
    qDebug() << "Delete Serial SerialWorker";

    qDebug() << "End Application";
    return rv;
}
