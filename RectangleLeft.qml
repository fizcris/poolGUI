import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    property alias scadaItem: scadaItem
    id: rectangleLeft_priv
    color: "transparent"

    Rectangle {
        id: background
        color: "green"
        width: parent.width
        height: parent.height
        opacity: 0.4
    }
    Scada {
        id: scadaItem
    }
    Text {
        id: text_designed_by
        x: 10
        y: 940
        width: 800
        height: 30
        text: qsTr("Designed By C. Alonso in Galifornia")
        elide: Text.ElideNone
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        lineHeightMode: Text.ProportionalHeight
        wrapMode: Text.WrapAnywhere
        maximumLineCount: 2
        font.family: "Courier"
        font.bold: true
        color: "gray"
        font.pointSize: 28
    }
    
}
