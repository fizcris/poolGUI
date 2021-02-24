import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    property alias checked: cold_hot_switch.checked

    function toggleState() {
        if (cold_hot_comp.state == "cold")
            cold_hot_comp.state = "hot";
        else
            cold_hot_comp.state = "cold";
    }

    id: cold_hot_comp
    state: "hot"
    implicitHeight: 120
    implicitWidth: parent.width
    anchors{
        left: parent.left
        leftMargin: 115}

    Grid{
        width: 400
        height: parent.height
        columns: 3; rows: 1
        spacing: 5

        Rectangle{height: parent.height; width: 200;
            color: "transparent"; clip: true;

            Image {
                id: hot_icon
                width: sourceSize.width
                height: sourceSize.height
                anchors {right: parent.right
                    rightMargin: 0
                    verticalCenter: parent.verticalCenter
                }
                source: "qrc:/resources/icons/icon_hot.png"
                visible: true
                ColorOverlay {
                    id: hot_icon_color
                    anchors.fill: parent
                    source: parent
                    color: "orange"
                }
                TapHandler {
                    id: tapHandlerHotIcon
                    enabled: rectangleTop.switchOnOff.checked
                    onTapped: cold_hot_switch.checked = false
                }
            }

        }
        Rectangle{height: parent.height; width: 200;
            color: "transparent"; clip: true

            Switch {
                id: cold_hot_switch
                checked: false
                scale: 2.5
                enabled: rectangleTop.switchOnOff.checked
                onCheckedChanged: {
                    toggleState();
                }
                anchors.centerIn: parent

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
        }
        Rectangle{height: parent.height; width: 200; color: "transparent" ; clip: true

            Image {
                id: cold_icon
                width: sourceSize.width
                height: sourceSize.height
                anchors {
                    left: parent.left
                    leftMargin: 0
                    verticalCenter: parent.verticalCenter
                }
                source: "qrc:/resources/icons/icon_cold.png"
                visible: true

                ColorOverlay {
                    id: cold_icon_color
                    anchors.fill: parent
                    source: parent
                    color: "blue"
                    //visible: false
                }
            }
            TapHandler {
                id: tapHandlerColdtIcon
                enabled: rectangleTop.switchOnOff.checked
                onTapped: cold_hot_switch.checked = true
            }
        }
    }


    states: [
        State {
            name: "hot"
            PropertyChanges { target: cold_icon_color; visible: false }
            PropertyChanges { target: hot_icon_color; visible: true }
            //PropertyChanges { target: cold_hot_switch.indicator.childrenRect; color: "red" }
            PropertyChanges { target: dial_mode; dialValue: 1 }

        },
        State {
            name: "cold"
            PropertyChanges { target: cold_icon_color; visible: true }
            PropertyChanges { target: hot_icon_color; visible: false }

            PropertyChanges { target: dial_mode; dialValue: 2 }
        }
    ]

    transitions: [
        Transition {
            // Update dial state
            ScriptAction {
                script: dial_mode.setState()
            }
        }
    ]
}
