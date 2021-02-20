import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle{
    id: cold_hot_comp
    width: 320
    height: 80
    color: "transparent"

    Image {
        id: hot_icon
        width: 60
        height: 60
        anchors {
            left: parent.left
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/resources/icons/icon_hot.png"
        visible: true

        ColorOverlay {
            id: hot_icon_color
            anchors.fill: parent
            source: parent
            //color: "#ff0000"  // red
            color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: !cold_hot_switch.checked
        }
    }

    Switch {
        id: cold_hot_switch
        //width: 120
        //height: 56
        checked: false
        scale: 2.5


        anchors {
            left: hot_icon.right
            leftMargin: 60
            verticalCenter: parent.verticalCenter
        }

        //contentItem: Text {
        //rightPadding: on_off_switch.indicator.width + on_off_switch.spacing
        //text: cold_hot_switch.checked  ? qsTr("ON") : qsTr("OFF")
        //font.family: "Verdana"
        //opacity: enabled ? 1.0 : 0.3
        //color: on_off_switch.checked  ? "#17a81a" : "red"
        //elide: Text.ElideRight
        //verticalAlignment: Text.AlignVCenter
        //}

        indicator: Rectangle {
            implicitWidth: 48
            implicitHeight: 26
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            radius: 13
            color: cold_hot_switch.checked ? "blue" : "orange"
            border.color: cold_hot_switch.checked ? "#cccccc" : "#cccccc"

            Rectangle {
                x: cold_hot_switch.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: cold_hot_switch.down ? "#cccccc" : "#ffffff"
                //border.color: cold_hot_switch.checked ? (cold_hot_switch.down ? "#17a81a" : "#21be2b") : "#999999"
            }
        }
    }

    Image {
        id: cold_icon
        width: 80
        height: 80
        anchors {
            left: cold_hot_switch.right
            leftMargin: 50
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/resources/icons/icon_cold.png"
        visible: true

        ColorOverlay {
            id: cold_icon_color
            anchors.fill: parent
            source: parent
            color: "blue"
            //color: "#ff0000"  // red
            //color: "#d98123"  //orange
            //color: "#228a08"  //green
            visible: cold_hot_switch.checked
        }
    }
}
