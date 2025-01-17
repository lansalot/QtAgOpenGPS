import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.2

Rectangle{
    id:fieldOpen
    color: "ghostwhite"
    visible: false
    width: 1024
    height: 700
    z:3
    Rectangle {
        id: topLine
        objectName: "topLine"
        width: parent.width
        height: screenPixelDensity * 0.3 //.3" tall
        color: "ghostwhite"
        z: 4
        Text {
            id: field
            text: "Field"
            anchors.left: topLine.left
            anchors.leftMargin: 15
            anchors.verticalCenter: topLine.verticalCenter
        }
        Text {
            id: distance
            text: qsTr("Distance")
            anchors.right: area.left
            anchors.verticalCenter: topLine.verticalCenter
            anchors.rightMargin: 100
        }
        Text {
            id: area
            text: qsTr("Area")
            anchors.right: parent.right
            anchors.verticalCenter: topLine.verticalCenter
            anchors.rightMargin: 30
        }
    }
    ListView {
        anchors.top: topLine.bottom
        anchors.bottom: grid3.top
        width:parent.width - 10
        anchors.left: parent.left
        anchors.leftMargin: 5
        property Component mycomponent: fileName
        model :FolderListModel{
            id: fieldList
            showDirs: true
            showFiles: false
            folder: "file:/home/davidwedel/Documents/QtAgOpenGPS/Fields/"
        }

        delegate: RadioButton{
            id: control
            indicator: Rectangle{
                border.width: 1
                border.color: "black"
                anchors.fill: parent
                color: "lightgray"
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: 1
                    color: control.down ? "white" : "blue"
                    visible: control.checked
                }
            }

            width:parent.width
            height:50
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                text: fileName
                font.pixelSize: 25
                font.bold: true
                color: control.checked ? "white" : "black"
                z: 2
            }
        }
    }

    Rectangle{
        id: grid3
        z: 4
        width: parent.width - 10
        height: deleteField.height + 10
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        color: "white"
        Grid {
            anchors.fill: parent
            spacing: 60
            flow: Grid.TopToBottom
            rows: 1
            columns: 4
            IconButtonText {
                id: deleteField
                objectName: "btnDeleteField"
                icon.source: "/images/skull.png"
                text: "Delete Field"
                color3: "white"
                border: 1
                height: 75
            }
            IconButtonText {
                id: sort
                objectName: "btnSort"
                icon.source: "/images/Sort.png"
                text: "Sort"
                color3: "white"
                border: 1
                height: 75
            }
            IconButtonText {
                id: cancel
                objectName: "btnCancel"
                icon.source: "/images/Cancel64.png"
                text: "Cancel"
                onClicked: fieldOpen.visible = false
                color3: "white"
                border: 1
                height: 75
            }
            IconButtonText {
                id: useSelected
                objectName: "btnUseSelected"
                icon.source: "/images/FileOpen.png"
                text: "Use Selected"
                color3: "white"
                border: 1
                height: 75
            }
        }
    }
}
