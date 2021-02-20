import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Rectangle {
    id: rectangleRight_priv
    x: 1080
    y: 100
    width: Window.width * 7/16
    height: Window.height - rectangleTop.height

    anchors {
        left: rectangleLeft.right
        top: parent.top
        topMargin: rectangleTop.height
    }

    Image {
        id: background_right_image
        width: parent.width
        height: parent.height
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        source: "qrc:/resources/images/background_right.jpg"
        visible: true
    }


    Hot_cold_switch {
        id: hc_switch
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }

    }


    Dial_mode {
        id: dial_mode
        height: 380
        anchors {
            top: hc_switch.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
    }

    Dial {
        id: dial
        x: 16
        y: 546
        width: 400
        height: 400
        hoverEnabled: true
        wrap: false
        inputMode: Dial.Circular
        snapMode: Dial.SnapAlways
        to: 40
    }

    Dial {
        id: dial1
        x: 437
        y: 545
        width: 400
        height: 400
    }
}
