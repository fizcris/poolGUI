import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0


Item  {
    id: dial_mode_priv

    //Input
    property alias dialValue: dial_dial_mode.value
    //Output
    property alias state: dial_mode_priv.state
    // Change state function
    function setState(){
        if (!rectangleTop.switchOnOff.checked)
            dial_mode_priv.state = "";
        else if (dial_dial_mode.value === 1 && !hc_switch.checked)
            dial_mode_priv.state = "hot_pool";
        else if (dial_dial_mode.value === 0 && !hc_switch.checked)
            dial_mode_priv.state = "hot_floor";
        else if (dial_dial_mode.value === 2 && !hc_switch.checked)
            dial_mode_priv.state = "hot_series";
        else if (dial_dial_mode.value === 3 && !hc_switch.checked)
            dial_mode_priv.state = "hot_paralell";
        else if (dial_dial_mode.value === 2 && hc_switch.checked)
            dial_mode_priv.state = "cold_series";
        else if (dial_dial_mode.value === 3 && hc_switch.checked)
            dial_mode_priv.state = "cold_paralell";
    }
    property int x1: 70
    property int x2: 170

    property real widthIcons: 200
    property real heightIcons: 180

    Grid {
        x:0;y:0
        width: parent.width
        height: parent.height
        columns: 2; rows: 2
        spacing: 0

        Item{
            id:pool_item
            width: parent.width/2
            height: parent.height/2
            Image {
                id: pool_icon
                width: widthIcons -30
                height: heightIcons -30
                x:x1
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/resources/icons/icon_pool.png"
                visible: true
                opacity: 1
                ColorOverlay {
                    id: pool_icon_color
                    anchors.fill: parent
                    source: parent
                    color: "gray"
                    visible: false
                }
            }
            TapHandler {
                id: tapHandlerPool
                enabled: rectangleTop.switchOnOff.checked && !hc_switch.checked
                onTapped: dial_dial_mode.value = 1
            }
        }
        Item {
            width: parent.width/2
            height: parent.height/2
            Image {
                id: series_icon
                width: widthIcons
                height: heightIcons - 60
                x:x2
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/resources/icons/icon_series.png"
                visible: true

                ColorOverlay {
                    id: series_icon_color
                    anchors.fill: parent
                    source: parent
                    color: "gray"
                    visible: false
                }


            }
            TapHandler {
                enabled: rectangleTop.switchOnOff.checked
                onTapped: dial_dial_mode.value = 2
            }
        }
        Item {
            width: parent.width/2
            height: parent.height/2
            Image {
                id: floor_icon
                width: widthIcons - 30
                height: heightIcons - 30
                x:x1
                anchors.verticalCenter: parent.verticalCenter

                source: "qrc:/resources/icons/icon_floor.png"
                visible: true
                opacity: 1

                ColorOverlay {
                    id: floor_icon_color
                    anchors.fill: parent
                    source: parent
                    color: "gray"
                    visible: false
                }
            }
            TapHandler {
                enabled: rectangleTop.switchOnOff.checked && !hc_switch.checked
                onTapped: dial_dial_mode.value = 0
            }
        }
        Item {
            width: parent.width/2
            height: parent.height/2
            Image {
                id: paralell_icon
                width: widthIcons
                height: heightIcons
                x:x2
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/resources/icons/icon_paralell.png"
                visible: true

                ColorOverlay {
                    id: paralell_icon_color
                    anchors.fill: parent
                    source: parent
                    color: "gray"
                    visible: false
                }
            }
            TapHandler {
                enabled: rectangleTop.switchOnOff.checked
                onTapped: dial_dial_mode.value = 3
            }
        }
    }
    Dial {
        id: dial_dial_mode
        width: 260
        height: 260
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        from: 0
        to: 3
        stepSize:1
        enabled: rectangleTop.switchOnOff.checked && !hc_switch.checked
        wrap: true
        inputMode: Dial.Circular
        snapMode: Dial.SnapAlways
        onValueChanged: {
            setState();
        }

        handle {
            visible: true
            scale: 3
        }
        background: Rectangle {
            id: knob_background
            x: dial_dial_mode.width / 2 - width / 2
            y: dial_dial_mode.height / 2 - height / 2
            width: Math.max(64, Math.min(dial_dial_mode.width, dial_dial_mode.height))
            height: width
            color: "gray"
            radius: width / 2
            //border.color: dial_dial_mode.pressed ? "#17a81a" : "#21be2b"
            opacity: 0.3
        }
        Text {
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            id: dial_text
            text: qsTr("......")

            font.pointSize: 40
            color: "#000000"
        }
    }
    state: ""
    states:[
        State{
            name:"hot_pool"
            PropertyChanges { target: dial_text; text: qsTr("Piscina") }
            PropertyChanges { target: pool_icon_color; color: "orange"; visible:true  }
            PropertyChanges { target: knob_background; color: "orange"; opacity: 1;}
            PropertyChanges { target: thermostat_pool; enabled: true;}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaImage; source: "qrc:/resources/scada/scada_hot_pool.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpPool; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpHeatEx; source: "qrc:/resources/scada/pump_on.png";}

        },
        State{
            name:"hot_floor"
            PropertyChanges { target: dial_text; text: qsTr("Suelo") }
            PropertyChanges { target: floor_icon_color; color: "orange"; visible:true  }
            PropertyChanges { target: knob_background; color: "orange"; opacity: 1;}
            PropertyChanges { target: thermostat_floor; enabled: true;}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaImage; source: "qrc:/resources/scada/scada_hot_floor.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk3; source: "qrc:/resources/scada/valve_vk3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk1; source: "qrc:/resources/scada/valve_vk1_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpFloor; source: "qrc:/resources/scada/pump_on.png";}
        },
        State{
            name:"hot_series"
            PropertyChanges { target: dial_text; text: qsTr("Serie") }
            PropertyChanges { target: series_icon_color; color: "orange"; visible:true  }
            PropertyChanges { target: knob_background; color: "orange"; opacity: 1;}
            PropertyChanges { target: thermostat_pool; enabled: true;}
            PropertyChanges { target: thermostat_floor; enabled: true;}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaImage; source: "qrc:/resources/scada/scada_hot_series.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk2; source: "qrc:/resources/scada/valve_3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk3; source: "qrc:/resources/scada/valve_vk3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpPool; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpHeatEx; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpFloor; source: "qrc:/resources/scada/pump_on.png";}
        },
        State{
            name:"hot_paralell"
            PropertyChanges { target: dial_text; text: qsTr("Paralelo") }
            PropertyChanges { target: paralell_icon_color; color: "orange"; visible:true  }
            PropertyChanges { target: knob_background; color: "orange"; opacity: 1;}
            PropertyChanges { target: thermostat_pool; enabled: true;}
            PropertyChanges { target: thermostat_floor; enabled: true;}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaImage; source: "qrc:/resources/scada/scada_hot_paralell.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk3; source: "qrc:/resources/scada/valve_vk3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpPool; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpHeatEx; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpFloor; source: "qrc:/resources/scada/pump_on.png";}
        },
        State{
            name:"cold_series"
            PropertyChanges { target: dial_text; text: qsTr("Serie") }
            PropertyChanges { target: series_icon_color; color: "blue"; visible:true  }
            PropertyChanges { target: pool_icon; opacity: 0.3;  }
            PropertyChanges { target: floor_icon; opacity: 0.3;  }
            PropertyChanges { target: knob_background; color: "blue"; opacity: 1;}
            PropertyChanges { target: thermostat_floor; enabled: true;}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaImage; source: "qrc:/resources/scada/scada_cold_series.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk2; source: "qrc:/resources/scada/valve_3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk4; source: "qrc:/resources/scada/valve_3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpPool; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpHeatEx; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpFloor; source: "qrc:/resources/scada/pump_on.png";}
        },
        State{
            name:"cold_paralell"
            PropertyChanges { target: dial_text; text: qsTr("Paralelo") }
            PropertyChanges { target: paralell_icon_color; color: "blue"; visible:true  }
            PropertyChanges { target: pool_icon; opacity: 0.3;  }
            PropertyChanges { target: floor_icon; opacity: 0.3;  }
            PropertyChanges { target: knob_background; color: "blue"; opacity: 1;}
            PropertyChanges { target: thermostat_floor; enabled: true;}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaImage; source: "qrc:/resources/scada/scada_cold_paralell.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk2; source: "qrc:/resources/scada/valve_3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadavk3; source: "qrc:/resources/scada/valve_vk3_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpPool; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpHeatEx; source: "qrc:/resources/scada/pump_on.png";}
            PropertyChanges { target: rectangleLeft.scadaItem.scadaPumpFloor; source: "qrc:/resources/scada/pump_on.png";}
        },
        State{
            name:""
        }

    ]

    transitions: [
        Transition {
            PropertyAnimation { property: "text"; easing.type: Easing.InOutQuad; duration: 0 }
            ColorAnimation { from: "#c0c0c0"; duration: 1000 }
            // On state change
            ScriptAction {
                script: console.log("Current State: ",dial_mode.state);
            }
        }
    ]
}
