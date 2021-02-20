import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rectangleTop_priv
    color: "#66ccff"
    width: Window.width
    height: 100
    anchors {
        left: Window.left
        top: Window.top
        topMargin: 0;
    }
    
    Text {
        id: time
        //anchors.centerIn: parent
        text: qsTr("22:45")
        color: "white"
        font.pointSize: 50
        anchors.left: parent.left
        anchors.leftMargin: 50
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
        anchors.leftMargin: 150
    }

    Switch {
        id: on_off_switch
        //width: 120
        //height: 56
        checked: false
        scale: 2.5

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 420
        }

        contentItem: Text {
            rightPadding: on_off_switch.indicator.width + on_off_switch.spacing
            text: on_off_switch.checked  ? qsTr("ON") : qsTr("OFF")
            font.family: "Verdana"
            font.pixelSize: 20
            opacity: enabled ? 1.0 : 0.3
            color: on_off_switch.checked  ? "#17a81a" : "red"
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        indicator: Rectangle {
            implicitWidth: 48
            implicitHeight: 26
            x: on_off_switch.width - width - on_off_switch.rightPadding
            y: parent.height / 2 - height / 2
            radius: 13
            color: on_off_switch.checked ? "#17a81a" : "red"
            border.color: on_off_switch.checked ? "#cccccc" : "#cccccc"

            Rectangle {
                x: on_off_switch.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: on_off_switch.down ? "#cccccc" : "#ffffff"
                border.color: on_off_switch.checked ? (on_off_switch.down ? "#17a81a" : "#21be2b") : "#999999"
            }
        }
    }
    
    
    Image {
        id: usb_icon
        x: 1613
        anchors.verticalCenterOffset: 0
        anchors {
            right: rectangleTop.right
            rightMargin: -180
            verticalCenter: rectangleTop.verticalCenter
        }
        source: "qrc:/resources/icons/icon_usb.png"
        scale: 0.2
        visible: false
    }
    
    ColorOverlay {
        id: usb_icon_color
        anchors.fill: usb_icon
        source: usb_icon
        //color: "#ff0000"  // red
        //color: "#d98123"  //orange
        color: "#228a08"  //green
        scale: usb_icon.scale
    }
    
}
