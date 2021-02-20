import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Rectangle {
    property real  marginX1: 20
    property real  marginY1: 5
    property real  marginX2: marginX1 + 600
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
        width: 300
        height: 300
        from: 0
        to: 3
        stepSize:1
        hoverEnabled: true
        wrap: true
        inputMode: Dial.Circular
        snapMode: Dial.SnapAlways
        handle {
            visible: true
            scale: 2
        }
    }

    Image {
        id: pool_icon
        width: widthIcons
        height: heightIcons
        anchors {
            left: parent.left
            leftMargin: marginX1
            top: parent.top
            topMargin: marginY1
        }
        source: "qrc:/resources/icons/icon_pool.png"
        visible: true

        ColorOverlay {
            id: pool_icon_color
            anchors.fill: parent
            source: parent
            color: "orange"
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            //visible: cold_hot_switch.checked
            visible: (dial_dial_mode.value == 1) ? true : false
        }
    }

    Image {
        id: floor_icon
        width: widthIcons
        height: heightIcons
        anchors {
            left: parent.left
            leftMargin: marginX1
            top: parent.top
            topMargin: marginY2
        }
        source: "qrc:/resources/icons/icon_floor.png"
        visible: true

        ColorOverlay {
            id: floor_icon_color
            anchors.fill: parent
            source: parent
            color: "orange"
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: (dial_dial_mode.value == 0) ? true : false
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
            color: "orange"
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: (dial_dial_mode.value == 2) ? true : false
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
            color: "orange"
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: (dial_dial_mode.value == 3) ? true : false
        }
    }



}
