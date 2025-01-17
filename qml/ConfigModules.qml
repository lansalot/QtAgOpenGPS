import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

/*todo:
 can't find setting for "invert relays"
 not sure about the "send button"
 */
    Rectangle{
        id: configModules
        anchors.fill: parent
        color: "ghostwhite"
        Text {
            id: titleText
            text: qsTr("Machine Module")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.top
            anchors.margins: 10
        }
        Rectangle{
            id: hydConfig
            anchors.left: parent.left
            color: "ghostwhite"
            border.color: "black"
            anchors.top: titleText.bottom
            anchors.topMargin: 20
            anchors.bottom: invertRel.top
            anchors.leftMargin: 10
            width: parent.width * .66
            Text {
                id: hydText
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Hydraulic Lift Config")
            }
            GridLayout{
                anchors.fill: parent
                flow: Grid.LeftToRight
                anchors.leftMargin: 10
                rows: 2
                columns: 3
                IconButtonColor{
                    objectName: "btnHydLiftEnable"
                    height: 130
                    width: 170
                    icon.source: "/images/SwitchOn.png"
                    checked: settings.setArdMac_isHydEnabled
                    onCheckedChanged: settings.setArdMac_isHydEnabled = checked
                }
                SpinBoxCustomized{
                    id: raiseTime
                    from:1
                    value: settings.setArdMac_hydRaiseTime
                    onValueChanged: settings.setArdMac_hydRaiseTime = value
                    to: 255
                    editable: true
                    text: qsTr("Raise Time(secs)")
                }
                Image{
                    source: "/images/Config/ConMa_LiftRaiseTime"
                    width: 200
                    height: 200
                }
                SpinBoxOneDecimal{
                    id: liftLookAhead
                    from:1
                    value: settings.setVehicle_hydraulicLiftLookAhead
                    onValueChanged: settings.setVehicle_hydraulicLiftLookAhead = value
                    to: 20
                    editable: true
                    text: qsTr("Hydraulic Lift Look Ahead
(secs)")
                }
                SpinBoxCustomized{
                    id: lowerTime
                    from:1
                    value: settings.setArdMac_hydLowerTime
                    onValueChanged: settings.setArdMac_hydLowerTime = value
                    to: 255
                    editable: true
                    text: qsTr("Lower Time(secs)")
                }
                Image{
                    source: "/images/Config/ConMa_LiftLowerTime"
                    width: 200
                    height: 200
                }
            }
        }
        IconButtonColor{
            id: invertRel
            anchors.horizontalCenter: hydConfig.horizontalCenter
            anchors.bottom: parent.bottom
            text: qsTr("Invert Relays")
            anchors.margins: 10
            icon.source: "/images/Config/ConSt_InvertRelay.png"
            checked: false
        }
        Rectangle{
            anchors.bottom: parent.bottom
            anchors.left: hydConfig.right
            anchors.right: parent.right
            anchors.top: titleText.bottom
            anchors.margins: 5
            Column{
                anchors.top: parent.top
                height: children.height
                spacing: 40
                anchors.horizontalCenter: parent.horizontalCenter
                SpinBoxCustomized{
                    id: user1
                    from: 0
                    value: settings.setArdMac_user1
                    onValueChanged: settings.setArdMac_user1
                    to: 255
                    editable: true
                    text: qsTr("User 1")
                }
                SpinBoxCustomized{
                    id: user2
                    from: 0
                    value: settings.setArdMac_user2
                    onValueChanged: settings.setArdMac_user2
                    to: 255
                    editable: true
                    text: qsTr("User 2")
                }
                SpinBoxCustomized{
                    id: user3
                    from: 0
                    value: settings.setArdMac_user3
                    onValueChanged: settings.setArdMac_user3
                    to: 255
                    editable: true
                    text: qsTr("User 3")
                }
                SpinBoxCustomized{
                    id: user4
                    from: 0
                    value: settings.setArdMac_user4
                    onValueChanged: settings.setArdMac_user4
                    to: 255
                    editable: true
                    text: qsTr("User 4")
                }
            }
            IconButtonTransparent{
                id: modulesSave
                objectName: "btnModulesSave"
                anchors.right: parent.right
                anchors.margins: 20
                anchors.bottom: parent.bottom
                icon.source: "/images/ToolAcceptChange.png"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.left
                    anchors.rightMargin: 5
                    text: qsTr("Send + Save")
                }
            }
        }
    }
