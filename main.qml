import QtQuick.Window 2.3
import QtQuick 2.12
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Window {
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Speedometer")
    color: "#000000"
    visibility:  "FullScreen"

    Rectangle {
        id: rectangleTop
        width: Window.width
        height: 160
        anchors.top: parent
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#66ccff"

        Text {
                    id: time
                    //anchors.centerIn: parent
                    text: qsTr("22:45")
                    color: "white"
                    font.pointSize: 50
                    anchors.centerIn: parent
                    anchors.horizontalCenter: parent.left

                }

        Text {
                    id: date
                    //anchors.centerIn: parent
                    text: qsTr("22 - 11 - 1992")
                    color: "white"
                    font.pointSize: 50
                }

    }

    Rectangle {
        id: rectangleLeft
        width: Window.width * 9/16
        height: Window.height- rectangleTop.height
        anchors.top: rectangleTop.bottom
        anchors.topMargin: 0
        color: "#d7fff7"
    }


    Rectangle {
        id: rectangleRight
        width: Window.width * 7/16
        height: Window.height - rectangleTop.height
        anchors.top: rectangleTop.bottom
        anchors.topMargin: 0
        anchors.left: rectangleLeft.right
        color: "#cbf359"

        Text {
            id: strText2
            //anchors.centerIn: parent
            text: qsTr("Hello2")
            color: "black"
            font.pointSize: 50
        }
    }

    MouseArea {
        anchors.fill: rectangleRight
        onClicked: {
            strText2.text = "Clicked"
        }
    }
}




