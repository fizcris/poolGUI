import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4


ColumnLayout{
    property alias value: gauge.value
    property alias max: rangeSlide.second
    property alias min: rangeSlide.first

    Gauge{
        id: gauge
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        orientation: Qt.Vertical
        minimumValue: -5
        maximumValue: 40
        minorTickmarkCount: 5
        tickmarkStepSize: 5

        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 16
                color: Qt.rgba(gauge.value / gauge.maximumValue, 0, 1 - gauge.value / gauge.maximumValue, 1)
            }
        }
        Behavior on value {
            PropertyAnimation{
                duration: 500
                easing.type: "InOutCubic"
            }
        }

        RangeSlider {
            anchors.fill: parent
            id: rangeSlide
            from: gauge.minimumValue
            to: gauge.maximumValue
            second.value: 26
            first.value: 18
            stepSize: 0.5
            snapMode:RangeSlider.SnapAlways
            orientation: "Vertical"
            function valueAt(pos){
                return ((to - from) * (1-pos) + from)
            }
            background: Item{}

            ToolTip {
                parent: rangeSlide.first.handle
                visible: rangeSlide.first.pressed
                text: rangeSlide.valueAt(rangeSlide.first.visualPosition).toFixed(2)
            }

            ToolTip {
                parent: rangeSlide.second.handle
                visible: rangeSlide.second.pressed
                text: rangeSlide.valueAt(rangeSlide.second.visualPosition).toFixed(2)
            }
        }
    }
        Label{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            text: qsTr("Temperature") + " Cº" + gauge.value.toFixed(2)
        }
}
