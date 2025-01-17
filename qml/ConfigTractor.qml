import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle{
    id: configTractor
    anchors.fill: parent
    visible: true
    color: "ghostwhite"
    Text {
        id: text
        text: qsTr("<h1>Choose Vehicle Type</h1>")
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ButtonGroup {
        buttons:  typesButtons.children
    }

    Row{
        id: typesButtons
        anchors.top: text.bottom
        anchors.horizontalCenter: parent.horizontalCenter


        IconButtonColor{
            id: harvester
            width:150
            height:100
            checkable: true
            icon.source: "/images/vehiclePageHarvester.png"
            checked: Number(settings.setVehicle_vehicleType) === 1 ? true: false
            onClicked: {
                if (checked)
                    settings.setVehicle_vehicleType = 1
            }

            Connections{
                target: settings
                function onSetVehicle_vehicleTypeChanged(){
                    if(Number(settings.setVehicle_vehicleType) === 1){
                        harvester.checked = true
                    }else{
                        harvester.checked = false
                    }
                }
            }
        }
        IconButtonColor{
            width:150
            height:100
            id: tractor
            icon.source: "/images/vehiclePageTractor.png"
            checkable: true
            checked: Number(settings.setVehicle_vehicleType) === 0 ? true: false
            onClicked: {
                if (checked)
                    settings.setVehicle_vehicleType = 0
            }
            Connections{
                target: settings
                function onSetVehicle_vehicleTypeChanged(){
                    if(Number(settings.setVehicle_vehicleType) === 0){
                        tractor.checked = true
                    }else{
                        tractor.checked = false
                    }
                }
            }
        }
        IconButtonColor{
            width:150
            height:100
            id: tr4wd
            icon.source: "/images/vehiclePage4WD.png"
            checkable: true
            checked: Number(settings.setVehicle_vehicleType) === 2 ? true: false
            onClicked: {
                if (checked)
                    settings.setVehicle_vehicleType = 2
            }

            Connections{
                target: settings
                function onSetVehicle_vehicleTypeChanged(){
                    if(Number(settings.setVehicle_vehicleType) === 2){
                        tr4wd.checked = true
                    }else{
                        tr4wd.checked = false
                    }
                }
            }
        }
    }
    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("I consider the rest of this page nonessential for now and will be added at a later date")
    }
}
