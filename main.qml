import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Window {
    id:root
    visible: true
    width: 1920
    height: 1080
    color: "#000000"
    visibility:  "FullScreen"


    //    AnimatedImage {
    //        id: animation_background
    //        source: "qrc:/resources/gifs/animation_right.gif"
    //        width: parent.width
    //        height: parent.height
    //    }

    RectangleTop {
        id: rectangleTop
        anchors {
            left: root.left
            top: root.top
            topMargin: 0;
            horizontalCenter: root.horizontalCenter
        }
        height: 100
        width: parent.width
    }

    RectangleLeft {
        id: rectangleLeft
    }

    RectangleRight {
        id: rectangleRight
        width: root.width * 7/16
        height: root.height - rectangleTop.height
        anchors {
            left: rectangleLeft.right
            top: parent.top
            topMargin: rectangleTop.height
        }
    }

    // Delete cursor
    MouseArea {
        id: allScreenActive
        anchors.fill: parent
        cursorShape: Qt.BlankCursor
        enabled: true
        propagateComposedEvents: true
        onClicked: mouse.accepted = false;
        onPressed: {playSound.play(); mouse.accepted = false;}
        onReleased: mouse.accepted = false;
        onDoubleClicked: mouse.accepted = false;
        onPositionChanged: mouse.accepted = false;
        onPressAndHold: mouse.accepted = false;

    }

    // TODO Implement animation on tap
    SoundEffect {
        id: playSound
        source: "qrc:/resources/sounds/tap_sound.wav"
    }

    Connections
    {
        target: serial
        function onChangedInput8(_value){
            if (_value){
                rectangleTop.warningIcon.visible = true;
            } else {
                rectangleTop.warningIcon.visible = false;
            }
        }
        function onChangedInput100(_value){
            return rectangleLeft.scadaItem.tempPool.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput101(_value){
            return rectangleLeft.scadaItem.tempFloor.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput102(_value){
            return rectangleLeft.scadaItem.tempHeater.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput103(_value){
            return rectangleLeft.scadaItem.tempPoolImp.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput104(_value){
            return rectangleLeft.scadaItem.tempFloorImp.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput105(_value){
            return rectangleLeft.scadaItem.tempReturn.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput106(_value){
            return rectangleLeft.scadaItem.tempSreies.text = qsTr((_value/10).toFixed(1) + "°C");
        }
        function onChangedInput107(_value){
            return rectangleLeft.scadaItem.pressureReturn.text = qsTr((_value/10).toFixed(1) + "bar");
        }
        function onChangedInput108(_value){
            return rectangleLeft.scadaItem.hgFloor.text = qsTr("" + (_value/10).toFixed(1) + "%");
        }
        function onChangedInput116(_value){
            return rectangleLeft.scadaItem.desiredTempPool.text = qsTr("" + (_value/10).toFixed(1) + "°C");
        }
        function onChangedInput117(_value){
            return rectangleLeft.scadaItem.desiredTempFloor.text = qsTr("" + (_value/10).toFixed(1) + "°C");
        }
        function onChangedInput118(_value){
            return rectangleRight.coldHotSwitch.desiredState.text = qsTr("" + (_value/10).toFixed(0)+ "/6")
        }
        function onChangedSerial(_value){
            if (_value){
                //TODO implement disable state (Problems with threads)
                rectangleTop.usbIconColor.color = "green";
                //rectangleTop.onOffSwitch.enabled = true;
                //rectangleTop.onOffSwitch.setState("disabled");
            }else{
                rectangleTop.usbIconColor.color = "red";
                //rectangleTop.onOffSwitch.switchOnOff.checked = false;
                //rectangleTop.onOffSwitch.enabled = false;
                //rectangleTop.onOffSwitch.setState("enabled");
            }
        }


    }
        //Heartbeat Serial signal with current state
        Timer {
            interval: 1000; running: true; repeat: true;
            onTriggered: {rectangleRight.dialMode.sendState(); }
        }


}
