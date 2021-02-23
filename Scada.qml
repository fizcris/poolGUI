import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    id: scadaComp
    width: parent.width
    height: parent.height

    property alias scadaImage: scada_full_image
    property alias scadavk1: scada_vk_1
    property alias scadavk2: scada_vk_2
    property alias scadavk3: scada_vk_3
    property alias scadavk4: scada_vk_4
    property alias scadaPumpPool: scada_pump_pool
    property alias scadaPumpHeatEx: scada_pump_heatEx
    property alias scadaPumpFloor: scada_pump_floor


    Image {
        id: scada_full_image
        width: parent.width
        height: parent.height
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        source: "qrc:/resources/scada/scada_base.png"
        visible: true
    }
    Image {
        id: scada_vk_1
        x: 423
        y: 470
        source: "qrc:/resources/scada/valve_vk1_off.png"
        visible: true

    }
    Image {
        id: scada_vk_2
        x: 914
        y: 470
        source: "qrc:/resources/scada/valve_3_base.png"
        visible: true

    }

    Image {
        id: scada_vk_3
        x: 430
        y: 675
        source: "qrc:/resources/scada/valve_vk3_off.png"
        visible: true
    }
    Image {
        id: scada_vk_4
        x: 202
        y: 803
        source: "qrc:/resources/scada/valve_3_base.png"
        visible: true
        rotation: 180
    }
    Image {
        id: scada_pump_pool
        x: 365
        y: 226
        source: "qrc:/resources/scada/pump_base.png"
        visible: true
    }
    Image {
        id: scada_pump_heatEx
        x: 615
        y: 479
        source: "qrc:/resources/scada/pump_base.png"
        visible: true
    }
    Image {
        id: scada_pump_floor
        x: 615
        y: 681
        source: "qrc:/resources/scada/pump_base.png"
        visible: true
    }

    Text {
        id: pool_temp_actual
        x: 100
        y: 50
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: true
        font.pointSize: 65
        color: "gray"
    }
    Text {
        id: floor_temp_actual
        x: 580
        y: 50
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: true
        font.pointSize: 55
        color: "gray"
    }
    Text {
        id: floor_hg_actual
        x: 870
        anchors.bottom: floor_temp_actual.bottom
        text: qsTr("34.5" + "%")
        font.family: "Roboto"
        font.bold: true
        font.pointSize: 40
        color: "gray"
    }
    Text {
        id: temp_heater
        x: 220
        y: 390
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: false
        font.pointSize: 25
        color: "black"
    }
    Text {
        id: temp_pool_imp
        x: 680
        y: 390
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: false
        font.pointSize: 25
        color: "black"
    }

    Text {
        id: temp_series
        x: 425
        y: 585
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: false
        font.pointSize: 25
        color: "black"
    }

    Text {
        id: temp_floor_imp
        x: 680
        y: 625
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: false
        font.pointSize: 25
        color: "black"
    }

    Text {
        id: temp_ret
        x: 420
        y: 880
        text: qsTr("34.5" + "°C")
        font.family: "Roboto"
        font.bold: false
        font.pointSize: 25
        color: "black"
    }

    Text {
        id: pressure
        x: 600
        y: 880
        text: qsTr("2.1" + "bar")
        font.family: "Roboto"
        font.bold: false
        font.pointSize: 25
        color: "black"
    }


}



