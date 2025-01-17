import QtQuick 2.0
import QtQuick.Controls 2.1
import Qt.labs.folderlistmodel 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item{
    Rectangle{
        id: topLine
        anchors.top:parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 1
        height: 30
        color: "white"
        Text {
            text: qsTr("Start New Field")
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
        }
    }
    Rectangle{
        id: mainFieldMenu
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topLine.bottom
        border.color: "lightblue"
        border.width: 2
        color: "black"
        ColumnLayout{
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            width: children.width
            IconButtonTextBeside{
                objectName: "btnFieldDriveIn"
                isChecked: false
                text: "Drive In"
                icon.source: "/images/AutoManualIsAuto.png"
            }
            IconButtonTextBeside{
                objectName: "btnFieldISOXML"
                isChecked: false
                text: "ISO-XML"
                icon.source: "/images/ISOXML.png"
            }
            IconButtonTextBeside{
                objectName: "btnFieldFromKML"
                isChecked: false
                text: "From KML"
                icon.source: "/images/BoundaryLoadFromGE.png"
                onClicked: fieldFromKML.visible = true
            }
            IconButtonTextBeside{
                objectName: "btnFieldFromExisting"
                isChecked: false
                text: "From Existing"
                icon.source: "/images/FileExisting.png"
                onClicked: fieldFromExisting.visible = true
            }
            IconButtonTextBeside{
                objectName: "New"
                isChecked: false
                text: "New"
                icon.source: "/images/FileNew.png"
                onClicked: fieldNew.visible = true
            }
        }
        ColumnLayout{
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.bottom: fieldCancel.top
            anchors.bottomMargin: 5
            width: children.width
            IconButtonTextBeside{
                objectName: "btnFieldResume"
                isChecked: false
                text: "Resume"
                icon.source: "/images/FilePrevious.png"
            }
            IconButtonTextBeside{
                objectName: "btnFieldClose"
                isChecked: false
                text: "Close"
                icon.source: "/images/FileClose.png"
            }
            IconButtonTextBeside{
                objectName: "btnFieldOpen"
                isChecked: false
                text: "Open"
                icon.source: "/images/FileOpen"
                onClicked: fieldOpen.visible = true;
            }
        }
        IconButtonTransparent{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10
            id: fieldCancel
            icon.source: "/images/Cancel64.png"
            //buttonText: "Cancel"
            onClicked: fieldMenu.visible = false
            height: 75
        }

        FieldFromExisting{
            id: fieldFromExisting
            anchors.top:parent.top
            anchors.topMargin: -50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
        FieldNew{
            id: fieldNew
            anchors.top:parent.top
            anchors.topMargin: -50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
        FieldFromKML{
            id: fieldFromKML
            anchors.top:parent.top
            anchors.topMargin: -50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
        FieldOpen{
            anchors.top:parent.top
            anchors.topMargin: -50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
    }
}
