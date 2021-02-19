import QtQuick.Window 2.3
import QtQuick 2.12
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Window {
    property real  scaleFactor: 0.2

    visible: true
    width: 1920
    height: 1080
    title: qsTr("poolGUI")
    color: "#000000"
    visibility:  "FullScreen"

    Rectangle {
        id: rectangleTop
        width: parent.width
        height: 100
        anchors.top: parent
        anchors.topMargin: 0
        color: "#66ccff"

        Text {
                id: time
                //anchors.centerIn: parent
                text: qsTr("22:45")
                color: "white"
                font.pointSize: 50
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter


                }

        Text {
                id: date
                //anchors.centerIn: parent
                text: qsTr("22 - 11 - 1992")
                color: "white"
                font.pointSize: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: time.right
                anchors.leftMargin: 50
                }


        Image {
            id: usb_icon
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/resources/icons/icon_usb.png"
            scale: scaleFactor
            visible: false
        }

        ColorOverlay {
                anchors.fill: usb_icon
                source: usb_icon
                //color: "#ff0000"  // red
                //color: "#d98123"  //orange
                color: "#228a08"  //green

                scale: scaleFactor
            }
    }

    Rectangle {
        id: rectangleLeft
        width: Window.width * 9/16
        height: Window.height- rectangleTop.height
        anchors.top: rectangleTop.bottom
        anchors.topMargin: 0
        color: "#d7fff7"
    }


    Rectangle {
        id: rectangleRight
        width: Window.width * 7/16
        height: Window.height - rectangleTop.height
        anchors.top: rectangleTop.bottom
        anchors.topMargin: 0
        anchors.left: rectangleLeft.right
        color: "#cceef7"

        Text {
            id: strText2
            x: 306
            y: 360
            //anchors.centerIn: parent
            text: qsTr("Hello2")
            color: "black"
            font.pointSize: 50
        }

        Switch {
            id: switch1
            x: 85
            y: 65
            width: 203
            height: 40
            text: "Suelo radiante"
            display: AbstractButton.TextBesideIcon
        }

        SwitchDelegate {
            id: switchDelegate
            x: 85
            y: 249
            width: 235
            height: 52
            text: qsTr("Piscina")
        }

        Switch {
            id: switch2
            x: 85
            y: 117
            width: 198
            height: 40
            text: qsTr("Piscina")
        }

        Switch {
            id: switch3
            x: 85
            y: 163
            width: 198
            height: 40
            text: qsTr("Series")
        }

        Switch {
            id: switch4
            x: 90
            y: 209
            width: 198
            height: 40
            text: qsTr("Paralelo")
        }

        Dial {
            id: dial
            x: 119
            y: 591
        }

        Dial {
            id: dial1
            x: 432
            y: 591
        }
    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:12}D{i:13}
}
##^##*/
