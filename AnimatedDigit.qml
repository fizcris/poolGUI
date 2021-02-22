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

Item {
    id: slider
    y: -thermostat_comp.roomViewTempHeight
    height: thermostat_comp.roomViewTempHeight * 3
    width: thermostat_comp.roomViewTempWidth/2

    property alias reversed: animation.reversed
    property alias stopAnimation: animation.stopAnimation

    property int prevValue: 0
    property int value: 0
    onValueChanged: {
        animation.start()
        prevValue = value
    }

    property int currentDigit: 0
    property int prevDigit: (currentDigit+9)%10
    property int nextDigit: (currentDigit+1)%10

    Column {
        Text {
            id: nextValueText
            visible: slider.visible;
            color: "#3d464d";
            text: slider.nextDigit
            font.pixelSize: thermostat_comp.wheelTempTextSize;
            font.family: "Roboto"
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            width: thermostat_comp.roomViewTempWidth/2
            height: thermostat_comp.roomViewTempHeight
        }
        Text {
            id: currentValueText
            visible: slider.visible;
            color: "#3d464d";
            text: slider.currentDigit
            font.pixelSize: thermostat_comp.wheelTempTextSize;
            font.family: "Roboto"
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            width: thermostat_comp.roomViewTempWidth/2
            height: thermostat_comp.roomViewTempHeight
        }
        Text {
            id: prevValueText
            visible: slider.visible;
            color: "#3d464d";
            text: slider.prevDigit
            font.pixelSize: thermostat_comp.wheelTempTextSize;
            font.family: "Roboto"
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            width: thermostat_comp.roomViewTempWidth/2
            height: thermostat_comp.roomViewTempHeight
        }
    }

    SequentialAnimation {
        id: animation
        property bool reversed: true
        property bool stopAnimation: false
        running: slider.currentDigit != slider.value

        ScriptAction {
            script: { // this script prevent situation when digits are not changed during fast change
                slider.currentDigit = ((animation.reversed ? slider.value + 1 : slider.value - 1) + 10) % 10
            }
        }
        NumberAnimation {
            target: slider
            property: "y"
            duration: animation.stopAnimation ? 0 : 250
            from: -thermostat_comp.roomViewTempHeight
            to: animation.reversed ? -2*thermostat_comp.roomViewTempHeight : 0
        }
        ScriptAction {
            script: {
                slider.currentDigit = slider.value
                slider.y = -thermostat_comp.roomViewTempHeight
            }
        }
    }
}
