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
            x: -1080
            y: 950
            width: 546
            height: 30
            //anchors.centerIn: parent
            text: qsTr("Designed By  C. Alonso in Galifornia")
            elide: Text.ElideNone
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            lineHeightMode: Text.ProportionalHeight
            wrapMode: Text.WrapAnywhere
            maximumLineCount: 2
            font.family: "Courier"
            minimumPointSize: 8
            minimumPixelSize: 8
            color: "#e61da4"
            font.pointSize: 50
        }

        Switch {
            id: switch2
            x: 330
            y: 14
            width: 180
            height: 56
            text: qsTr("ON/Off")
            font.family: "Verdana"
            font.pointSize: 16
            checked: false

            indicator.height: 300
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

        SwipeDelegate {
            id: swipeDelegate
            x: 142
            y: 142
            width: 194
            height: 86
            text: qsTr("Piscina")
            font.weight: Font.ExtraBold
            font.pointSize: 16
            font.family: "Verdana"
        }

        SwipeDelegate {
            id: swipeDelegate1
            x: 496
            y: 142
            width: 194
            height: 86
            text: qsTr("Piscina")
            font.family: "Verdana"
            font.weight: Font.ExtraBold
            font.pointSize: 16
        }

        SwipeDelegate {
            id: swipeDelegate2
            x: 142
            y: 258
            width: 194
            height: 86
            text: qsTr("Piscina")
            font.family: "Verdana"
            font.weight: Font.ExtraBold
            font.pointSize: 16
        }

        SwipeDelegate {
            id: swipeDelegate3
            x: 496
            y: 258
            width: 194
            height: 86
            text: qsTr("Piscina")
            font.family: "Verdana"
            font.weight: Font.ExtraBold
            font.pointSize: 16
        }

        SwipeDelegate {
            id: swipeDelegate4
            x: 342
            y: 412
            width: 194
            height: 86
            text: qsTr("Piscina")
            font.family: "Verdana"
            font.weight: Font.ExtraBold
            font.pointSize: 16
        }





    }
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:13}D{i:14}D{i:15}D{i:16}
}
##^##*/
