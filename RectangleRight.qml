import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rectangleRight_priv

    property alias dialMode: dial_mode
    property alias coldHotSwitch: hc_switch
    property alias thermostatPool: thermostat_pool
    property alias thermostatFloor: thermostat_floor

    color: "transparent"
    opacity: 0.3

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
    }
    Dial_mode {
       id: dial_mode
        width: parent.width
        height: 380
        anchors {
            top: hc_switch.bottom
            topMargin: 0
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
        enabled: false
        scale: 1.15
        displayText: qsTr("Piscina")

        onDesiredTempChanged: {serial.sendTemperaturePool(desiredTemp)}
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
        scale: 1.15
        displayText: qsTr("Ambiente")

       onDesiredTempChanged: {serial.sendTemperatureFloor(desiredTemp)}
    }
}
