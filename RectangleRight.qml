import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rectangleRight_priv
    color: "transparent"
    opacity: rectangleTop.switchOnOff.checked ? 1  : 0.3

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: "#F4AF1A"
        opacity: 0.05
    }
    //    Image {
    //        id: background_right_image
    //        width: pareanchorsnt.width
    //        height: parent.height
    //        anchors {
    //            verticalCenter: parent.verticalCenter
    //            horizontalCenter: parent.horizontalCenter
    //        }
    //        source: "qrc:/resources/images/background_right.jpg"
    //        visible: true
    //    }
    Hot_cold_switch {
        id: hc_switch
        implicitWidth: 120
        implicitHeight: 56
        anchors {
            top: parent.top
            topMargin: 50
            left: parent.left
            leftMargin: 250
        }
    }
    Dial_mode {
       id: dial_mode
        width: parent.width
        height: 380
        anchors {
            top: hc_switch.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
    }

    Thermostat {
        id: thermostat_pool
        width: parent.width/2
        height: parent.height - hc_switch.height -  dial_mode.height
        anchors {
            top: dial_mode.bottom
            left: parent.left
        }
        enabled: true
        //scale: 1.2
    }

    Thermostat {
        id: thermostat_floor
        width: parent.width/2
        height: parent.height - hc_switch.height -  dial_mode.height
        anchors {
            top: dial_mode.bottom
            left: thermostat_pool.right
        }
        enabled: false
        //scale: 1.2

    }
}
