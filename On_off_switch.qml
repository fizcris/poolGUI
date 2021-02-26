import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Switch {
    id: on_off_switch

    property alias switchOnOff: on_off_switch

    opacity: 1
    //width: 120
    //height: 56
    checked: false
    scale: 2.5
    
    function setState(value){
        if (value === "ON"){on_off_switch.state = "ON";};
        if (value === "OFF"){on_off_switch.state = "OFF";};
        if (value === "disabled"){on_off_switch.state = "disabled";};
        if (value === "enabled"){on_off_switch.state = "enabled";};
    }

    function toggleState() {
        if (on_off_switch.state == "ON")
            on_off_switch.state = "OFF";
        else
            on_off_switch.state = "ON";
    }

    //Update Dial_mode state
    onCheckedChanged: {
        rectangleRight.dialMode.setState();
        toggleState();
        if (!on_off_switch.checked) {serial.sendStateStop(1);}
    }
    anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: 420
    }
    contentItem: Text {PropertyChanges { target: on_off_switch; opacity:1  }
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
        id: on_off_switch_icon
        implicitWidth: 48
        implicitHeight: 26
        x: on_off_switch.width - width - on_off_switch.rightPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: on_off_switch.checked ? "#17a81a" : "red"
        border.color: on_off_switch.checked ? "#cccccc" : "#cccccc"
        opacity: enabled ? 1.0 : 0.3
        Rectangle {
            x: on_off_switch.checked ? parent.width - width : 0
            width: 26
            height: 26
            radius: 13
            color: on_off_switch.down ? "#cccccc" : "#ffffff"
            border.color: on_off_switch.checked ? (on_off_switch.down ? "#17a81a" : "#21be2b") : "#999999"
        }
    }

    state: "OFF"
    states: [
        State {
            name: "ON"
            PropertyChanges { target: on_off_switch; checked: true}
            PropertyChanges { target: rectangleRight; opacity: 1}
            PropertyChanges { target: rectangleRight.coldHotSwitch; enabled: true}
            PropertyChanges { target: rectangleRight.dialMode; enabled: true}

        },
        State {
            name: "OFF"
            PropertyChanges { target: on_off_switch; checked: false }
            PropertyChanges { target: rectangleRight; opacity: 0.3}
            PropertyChanges { target: rectangleRight.coldHotSwitch; enabled: false}
            PropertyChanges { target: rectangleRight.dialMode; enabled: false}

        }//,
//        State {
//            name: "disabled"
//            PropertyChanges { target: rectangleRight.coldHotSwitch; enabled: false}
//            PropertyChanges { target: on_off_switch; state: "OFF" }

//        },
//        State {
//            name: "enabled"
//            PropertyChanges { target: rectangleRight.coldHotSwitch; enabled: true}
//            PropertyChanges { target: on_off_switch; state: "OFF" }
//        }
    ]
}



