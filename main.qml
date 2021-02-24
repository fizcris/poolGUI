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
}



