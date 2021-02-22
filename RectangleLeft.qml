import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rectangleLeft_priv
    color: "transparent"
    width: root.width * 9/16
    height: root.height - rectangleTop.height
    anchors {
        left: root.left
        top: rectangleTop.top
        topMargin: rectangleTop.height
    }

    Rectangle {
        id: background
        color: "green"
        width: parent.width
        height: parent.height
        opacity: 0.3
    }

    Image {
        id: background_right_image
        width: parent.width
        height: parent.height
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        source: "qrc:/resources/scada/scada_full.png"
        visible: true
    }
        
    Text {
        id: text_designed_by
        x: 10
        y: 940
        width: 800
        height: 30
        //anchors.centerIn: parent
        text: qsTr("Designed By C. Alonso in Galifornia")
        elide: Text.ElideNone
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        lineHeightMode: Text.ProportionalHeight
        wrapMode: Text.WrapAnywhere
        maximumLineCount: 2
        font.family: "Courier"
        color: "black"
        font.pointSize: 28
    }
    
}
