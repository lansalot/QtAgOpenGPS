import QtQuick.Controls 2.15
import QtGraphicalEffects 1.13
import QtQuick 2.15

Slider{
    value: 0
    id: sliderCustomized
    property double multiplicationValue: 1
    property string leftText: ""
    property string rightText: ""
    property string centerTopText: ""
    property string leftTopText: ""
    property string rightTopText: ""
    property color colorLeftTopText: "black"
    property color colorRightTopText: "black"


    background: Rectangle {
        id: backgroundRect
        x: parent.leftPadding
        y: parent.topPadding + parent.availableHeight / 2 - height / 2
        implicitWidth: 250 + 30
        implicitHeight: 50
        width: parent.availableWidth
        height: implicitHeight
        radius: 2
        color: "lightgray"

    }

    handle: Rectangle{
        height: parent.height
        width: 20
        visible: true
        color: "grey"
        x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
        y: parent.topPadding + parent.availableHeight / 2 - height / 2

    }
    Button{
        id: rightSliderButton
        anchors.right: sliderCustomized.right
        anchors.top: sliderCustomized.top
        anchors.bottom: sliderCustomized.bottom
        width: 20
        onClicked: sliderCustomized.value = sliderCustomized.value +1 * multiplicationValue
        Text{
            anchors.centerIn: parent
            text: qsTr(">")

        }
    }
    Button{
        id: leftSliderButton
        anchors.left: sliderCustomized.left
        anchors.top: sliderCustomized.top
        onClicked: sliderCustomized.value = sliderCustomized.value -1 * multiplicationValue
        anchors.bottom: sliderCustomized.bottom
        width: 20
        Text{
            anchors.centerIn: parent
            text: qsTr("<")
        }
    }
    Text{
        id: leftText
        text: sliderCustomized.leftText
        anchors.right: parent.left
        anchors.verticalCenter: backgroundRect.verticalCenter
    }
    Text{
        id: rightText
        text: sliderCustomized.rightText
        anchors.left: parent.right
        anchors.verticalCenter: backgroundRect.verticalCenter
    }
    Text{
        id: leftTopText
        text: sliderCustomized.leftTopText
        anchors.left:  parent.left
        anchors.bottom: parent.top
        color: parent.colorLeftTopText
    }
    Text{
        id: rightTopText
        text: sliderCustomized.rightTopText
        anchors.right: parent.right
        anchors.bottom: parent.top
        color: parent.colorRightTopText
    }
    Text{
        id: centerTopText
        text: sliderCustomized.centerTopText
        anchors.bottom: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
