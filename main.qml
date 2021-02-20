import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0



Window {
    //property real  scaleFactor: 0.2
    id:mainWindow
    visible: true
    width: 1920
    height: 1080
    //title: qsTr("poolGUI")
    color: "#000000"
    visibility:  "FullScreen"

    RectangleTop {
        id: rectangleTop
        anchors {
            horizontalCenter: mainWindow.horizontalCenter
            topMargin: 40
        }
    }

    RectangleLeft {
        id: rectangleLeft
        color: "#d7fff7"
    }

    RectangleRight {
        id: rectangleRight
        color: "red"
    }

    // Delete cursor
    MouseArea {
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.BlankCursor
    }
    // TODO Implement animation on tap
    TapHandler {
        onTapped: console.log("left clicked")
    }
}



