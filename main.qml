import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0



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
        width: root.width * 9/16
        height: root.height - rectangleTop.height
        anchors {
            left: root.left
            top: rectangleTop.top
            topMargin: rectangleTop.height
        }
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
        id: allScreen
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.BlankCursor
    }
    // TODO Implement animation on tap
    TapHandler {
        onTapped: console.log("Add sound")
    }
}



