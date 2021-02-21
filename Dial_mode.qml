import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Rectangle {
    property alias dialValue: dial_dial_mode.value

    property real  marginX1: 45
    property real  marginY1: 5
    property real  marginX2: marginX1 + 550
    property real  marginY2: marginY1 + 200

    property real widthIcons: 200
    property real heightIcons: 180
    id: dial_mode_priv
    width: parent.width
    color: "transparent"

    Dial {
        id: dial_dial_mode
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        width: 260
        height: 260
        from: 0
        to: 3
        stepSize:1
        enabled: rectangleTop.checked && !hc_switch.checked
        wrap: true
        inputMode: Dial.Circular
        snapMode: Dial.SnapAlways
        handle {
            visible: true
            scale: 3
        }

        background: Rectangle {
                x: dial_dial_mode.width / 2 - width / 2
                y: dial_dial_mode.height / 2 - height / 2
                width: Math.max(64, Math.min(dial_dial_mode.width, dial_dial_mode.height))
                height: width
                color: hc_switch.checked ? "blue" : "orange";
                radius: width / 2
                border.color: dial_dial_mode.pressed ? "#17a81a" : "#21be2b"
                opacity: dial_dial_mode.enabled ? 0.6 : 0.3
            }


        Text {
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            id: dial_text
            text: {
                if (dial_dial_mode.value == 0) return qsTr("Ambiente")
                if (dial_dial_mode.value == 1) return qsTr("Piscina")
                if (dial_dial_mode.value == 2) return qsTr("Serie")
                if (dial_dial_mode.value == 3) return qsTr("Paralelo")
            }

            font.pointSize: 40
            color: "#000000"
        }
    }

    Image {
        id: pool_icon
        width: widthIcons -30
        height: heightIcons -30
        anchors {
            left: parent.left
            leftMargin: marginX1
            top: parent.top
            topMargin: marginY1
        }
        source: "qrc:/resources/icons/icon_pool.png"
        visible: true
        opacity: hc_switch.checked ? 0.3 : 1

        ColorOverlay {
            id: pool_icon_color
            anchors.fill: parent
            source: parent
            color: hc_switch.checked ? "blue" : "orange";
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            //visible: cold_hot_switch.checked
            visible: (dial_dial_mode.value == 1) ? true : false
        }

        TapHandler {
            enabled: rectangleTop.checked && !hc_switch.checked
            onTapped: dial_dial_mode.value = 1
        }
    }

    Image {
        id: floor_icon
        width: widthIcons - 30
        height: heightIcons - 30
        anchors {
            left: parent.left
            leftMargin: marginX1
            top: parent.top
            topMargin: marginY2
        }
        source: "qrc:/resources/icons/icon_floor.png"
        visible: true
        opacity: hc_switch.checked ? 0.3 : 1

        ColorOverlay {
            id: floor_icon_color
            anchors.fill: parent
            source: parent
            color: hc_switch.checked ? "blue" : "orange";
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: (dial_dial_mode.value == 0) ? true : false
        }
        TapHandler {
            enabled: rectangleTop.checked && !hc_switch.checked
            onTapped: dial_dial_mode.value = 0
        }
    }


    Image {
        id: series_icon
        width: widthIcons
        height: heightIcons - 60
        anchors {
            left: parent.left
            leftMargin: marginX2
            top: parent.top
            topMargin: marginY1
        }
        source: "qrc:/resources/icons/icon_series.png"
        visible: true

        ColorOverlay {
            id: series_icon_color
            anchors.fill: parent
            source: parent
            color: hc_switch.checked ? "blue" : "orange";
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: (dial_dial_mode.value == 2) ? true : false
        }

        TapHandler {
            enabled: rectangleTop.checked
            onTapped: dial_dial_mode.value = 2
        }
    }


    Image {
        id: paralell_icon
        width: widthIcons
        height: heightIcons
        anchors {
            left: parent.left
            leftMargin: marginX2
            top: parent.top
            topMargin: marginY2
        }
        source: "qrc:/resources/icons/icon_paralell.png"
        visible: true


        ColorOverlay {
            id: paralell_icon_color
            anchors.fill: parent
            source: parent
            color: hc_switch.checked ? "blue" : "orange";
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: (dial_dial_mode.value == 3) ? true : false
        }

        TapHandler {
            enabled: rectangleTop.checked
            onTapped: dial_dial_mode.value = 3
        }
    }


}
