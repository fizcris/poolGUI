/******************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Ultralite module.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
******************************************************************************/
import QtQuick 2.12
import QtGraphicalEffects 1.0


Item {
    id: thermostat_comp
    property alias isEnabled:  thermostat_comp.enabled
    property alias displayText: text_display.text
    property int desiredTemp: currentTemp*10


    //Size of the dial for digits
    readonly property int roomViewTempWidth: 150
    readonly property int roomViewTempHeight: 120
    //Size of the digits
    readonly property int wheelTempTextSize: 120
    //Size of the  units
    readonly property int wheelTempUnitSize: 32
    readonly property string temperatureSymbol: "°C"
    //Vertical offset for digits
    readonly property int tempControlOffset: 13
    // Colors
    readonly property color blue: "#3c94eb";
    readonly property color greyMedium3: "#c4c9cc";
    // Temperatures
    property int currentTemp: 20
    property int prevTemp: 19
    property int maxTemp: 40
    property int minTemp: 10
    //Slider properties
    property int smallestAngle : 25;
    readonly property real wheelSize: 155
    readonly property int thermoHandleSize: 100


    onVisibleChanged: {
        setTemperatureWithoutAnimation(currentTemp)
    }
    onCurrentTempChanged: {
        desiredTemp = currentTemp*10
    }
    function setTemperature(t : real) {
        _setTemperatureImpl(t, false)
    }
    function setTemperatureWithoutAnimation(t : real) {
        _setTemperatureImpl(t, true)
    }
    function _setTemperatureImpl(t : real, stopAnimation : bool) {
        currentTemp = Math.min(Math.max(Math.round(t), minTemp), maxTemp);
        tens.stopAnimation = stopAnimation
        ones.stopAnimation = stopAnimation
        tens.reversed = currentTemp < prevTemp
        ones.reversed = currentTemp < prevTemp
        prevTemp = currentTemp
    }
    Item {
        id: temp_dial
        width: wheelImg.width
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        Image {
            id: wheelImg
            source: thermostat_comp.enabled ? "qrc:/resources/icons/jog.png" : "qrc:/resources/icons/jog-off.png"
        }
        Row {
            clip: true
            id: thermoText
            anchors.centerIn: parent
            width: thermostat_comp.roomViewTempWidth
            height: thermostat_comp.roomViewTempHeight

            //Rectangle {width: 50; height: 50;color: "red";opacity: 0.7}
            //Rectangle {width: 50; height: 50;color: "blue";opacity: 0.7}

            AnimatedDigit {
                id: tens
                visible: thermostat_comp.enabled
                value: thermostat_comp.currentTemp / 10
            }
            AnimatedDigit {
                id: ones
                visible: thermostat_comp.enabled
                value: thermostat_comp.currentTemp % 10
            }
        }
        Image {
            id: digitMaskTop
            anchors.top: thermoText.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/resources/icons/digitMaskTop.png"
            visible: false
        }
        Image {
            id: digitMaskBottom
            anchors.bottom: thermoText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/resources/icons/digitMaskBottom.png"
            visible: false
        }
        Text {
            visible: thermostat_comp.enabled
            color: "#3d464d"
            anchors.top: thermoText.top
            anchors.left: thermoText.right
            anchors.topMargin: 13
            text: thermostat_comp.temperatureSymbol
            font.pixelSize: thermostat_comp.wheelTempUnitSize
            font.family: "Roboto Medium"
        }
        MouseArea {
            visible: thermostat_comp.enabled

            width: parent.width
            height: parent.height / 2

            Image {
                visible: parent.pressed
                source: "qrc:/resources/icons/pressed-bg-up.png"
                anchors.centerIn: parent
            }
            Image {
                source: "qrc:/resources/icons/temp-up-pressed.png"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: thermostat_comp.tempControlOffset

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: parent.parent.pressed ? thermostat_comp.blue : thermostat_comp.greyMedium3
                    visible: true
                }
            }

            onClicked: {
                thermostat_comp.setTemperature(thermostat_comp.currentTemp+1);
            }
        }
        MouseArea {
            visible: thermostat_comp.enabled

            width: parent.width
            height: parent.height / 2
            anchors.bottom: parent.bottom
            Image {
                visible: parent.pressed
                source: "qrc:/resources/icons/pressed-bg-down.png"
                anchors.centerIn: parent
            }
            Image {
                visible: true
                source: "qrc:/resources/icons/temp-down-pressed.png"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -thermostat_comp.tempControlOffset

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: parent.parent.pressed ? thermostat_comp.blue : thermostat_comp.greyMedium3
                    visible: true
                }
            }
            onClicked: {
                thermostat_comp.setTemperature(thermostat_comp.currentTemp-1);
            }
        }

        Image {
            id: thermoHandle
            visible: thermostat_comp.enabled
            z: 10
            //scale: 2
            source: "qrc:/resources/icons/inner-circle.png"
            property real angle: (90 + thermostat_comp.smallestAngle + (thermostat_comp.currentTemp - thermostat_comp.minTemp)/(thermostat_comp.maxTemp-thermostat_comp.minTemp)  * (360-2*thermostat_comp.smallestAngle) )
                                 * 2 * Math.PI / 360

            x : parent.width/2 - width/2 + thermostat_comp.wheelSize * Math.cos(angle)
            y : parent.height/2 - height/2 + thermostat_comp.wheelSize * Math.sin(angle)

            MouseArea {
                anchors.centerIn: parent
                width: thermostat_comp.thermoHandleSize
                height: thermostat_comp.thermoHandleSize

                property real pressedX: 0
                property real pressedY: 0

                onPressed: {
                    pressedX = mouse.x
                    pressedY = mouse.y
                }

                onPositionChanged: {
                    var px = mouse.x - pressedX + x + width/2 + parent.x - parent.parent.width / 2
                    var py = mouse.y - pressedY + y + height/2 + parent.y - parent.parent.height / 2
                    var d = Math.sqrt(px*px + py*py);
                    if (d < thermostat_comp.wheelSize * 0.6)
                        return; // too far from the position
                    var angle = Math.atan2(px / d, py / d) * 360 / (Math.PI*2);
                    angle = (360 - angle);
                    while (angle > 360)
                        angle-=360;
                    var temperature = thermostat_comp.minTemp + (angle-thermostat_comp.smallestAngle) * (thermostat_comp.maxTemp-thermostat_comp.minTemp) / (360-2*thermostat_comp.smallestAngle);
                    //console.log(temperature)
                   thermostat_comp.setTemperatureWithoutAnimation(temperature);
                }

                Image {
                    source: "qrc:/resources/icons/thermo-handle.png"
                    visible: parent.pressed
                    anchors.centerIn: parent;
                }
            }
        }

    }
    Text{
        id: text_display
    height: 40
    //width: parent.width //Better way to define a non fixed widht?
    anchors.horizontalCenter: temp_dial.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    //anchors.top: thermostat_comp.bottom
    text: qsTr("Thermostat")
    color: "white"
    font.pixelSize: 40
    }
}



