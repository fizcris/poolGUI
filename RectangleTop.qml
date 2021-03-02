import QtQuick 2.12
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: rectangleTop_priv
    color: "transparent"
    opacity: 1

    property alias  usbIconColor: usb_icon_color
    property alias  onOffSwitch: on_off_switch

    property string hours: "00"
    property string minutes: "00"
    property string seconds: "00"
    property string day: "00"
    property string month: "00"
    property string year: "0000"

    property bool night: false

    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: "#3FBFBF"
        opacity: 0.3
    }

    //    AnimatedImage {
    //        id: animation_top
    //        source: "qrc:/resources/gifs/animation_top.giff"
    //        width: parent.width
    //        height: parent.height
    //    }

    // Function to update hour and date
    function timeChanged() {
        var date = new Date;
        hours = ((date.getUTCHours() +1)>=10) ? (date.getUTCHours()+1) : '0' + (date.getUTCHours()+1);
        night = ( (date.getUTCHours() +1) < 7 || (date.getUTCHours() +1) > 19 )
        minutes = (date.getUTCMinutes()>=10 ? date.getUTCMinutes() : '0' + date.getUTCMinutes());
        seconds = (date.getUTCSeconds()>=10 ? date.getUTCSeconds() : '0' + date.getUTCSeconds());
        day = (date.getDate()>=10 ? date.getDate() : '0' + date.getDate());
        month = ((date.getMonth()+1)>=10) ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
        year = date.getUTCFullYear()

    }
    // Timmer to update hour and date
    Timer {
        interval: 500; running: true; repeat: true;
        onTriggered: rectangleTop_priv.timeChanged()
    }
    Text {
        id: time
        //anchors.centerIn: parent
        text: qsTr(rectangleTop_priv.hours + ":" + rectangleTop_priv.minutes + ":" + rectangleTop_priv.seconds )
        color: "#000000"
        font.pointSize: 50
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
    }
    Text {
        id: date
        //anchors.centerIn: parent
        text: qsTr(rectangleTop_priv.day + " - " + rectangleTop_priv.month + " - "+ rectangleTop_priv.year )
        color: "#000000"
        font.pointSize: 50
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: time.right
        anchors.leftMargin: 150
    }

    On_off_switch {
        id: on_off_switch
    }


    Image {
        id: warning_icon
        anchors {
            right: parent.right
            rightMargin: 200
            verticalCenter: rectangleTop.verticalCenter
        }
        source: "qrc:/resources/icons/warning.png"
        scale: 1
        visible: true
    }


    Image {
        id: usb_icon
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: rectangleTop.verticalCenter
        }
        source: "qrc:/resources/icons/icon_usb.png"
        scale: 1
        visible: true

        ColorOverlay {
            id: usb_icon_color
            anchors.fill: parent
            source: parent
            color: "red"
        }
    }
}

