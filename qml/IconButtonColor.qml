import QtQuick 2.7
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0


Button {
    implicitWidth: 120
    implicitHeight: 65
    id: icon_button
    text: ""
    hoverEnabled: true
    //checkable: true
    icon.source: ""
    icon.color: "transparent"

    property double iconHeightScaleText: 0.75
    property int border: 2

    property color color1: "white"
    property color color2: "#ffffff"
    property color color3: "#ffffff"

    property color colorHover1: "white"
    property color colorHover2: "white"
    property color colorHover3: "white"

    property color colorChecked1: "green"
    property color colorChecked2: "green"
    property color colorChecked3: "green"


    //For compatibility with the old IconButton and friends
    property bool isChecked: icon_button.checked
    property string buttonText: ""

    onButtonTextChanged: {
        text = buttonText
    }
    onIsCheckedChanged: {
        checked = isChecked;
    }

    //This is specific to this base type... must be re-implemented in subtypes
    onCheckedChanged: {
        isChecked = checked

        if (checked && useIconChecked) {
            content_image.source = iconChecked
            //console.warn("icon should be ", content_image.source)
        } else {
            content_image.source = icon.source
            //console.warn("icon should be ", content_image.source)
        }

    }

    property url iconChecked: ""
    property bool useIconChecked: false
    onIconCheckedChanged: {
        if (iconChecked != "") {
            useIconChecked = true
        } else {
            useIconChecked = false
        }
    }

    property int radius: 10
    onRadiusChanged: {
        icon_button_background.radius = radius
    }

    onWidthChanged: {
        //console.warn(text, "Width is now ", width)
    }

    onHeightChanged: {
        //console.warn(height)
    }
    contentItem: Rectangle {
        id: icon_button_content
        anchors.fill: parent
        color: "transparent"

        Text {
            id: text1
            text: icon_button.text
            anchors.bottom: parent.top
            anchors.left: parent.left
            font.bold: true
            font.pixelSize: parent.height * 0.2
            z: 1
            visible: true
        }

        Image {
            id: content_image
            width: parent.width
            anchors.fill: parent
            anchors.margins: 10
            fillMode: Image.PreserveAspectFit
            source: icon_button.icon.source
        }

        Colorize {
            id: disableFilter
            anchors.fill: content_image
            source: content_image
            hue: 0.0
            saturation: 0.0
            lightness: 0.2
            visible: ! icon_button.enabled
        }


    }

    background: Rectangle {
        border.width: icon_button.border
        //border.width: icon_button.border
        radius: 10
        id: icon_button_background
        gradient: Gradient {
            GradientStop {
                id: gradientStop1
                position: 0
                color: icon_button.color1
            }

            GradientStop {
                id: gradientStop2
                position: 0.5
                color: icon_button.color2
            }

            GradientStop {
                id: gradientStop3
                position: 1
                color: icon_button.color3
            }
        }

        states: [
            State {
                when: icon_button.down
                name: "pressedUnchecked"
                PropertyChanges {
                    target: gradientStop1
                    color: icon_button.color3
                }
                PropertyChanges {
                    target: gradientStop2
                    color: icon_button.color3
                }
                PropertyChanges {
                    target: gradientStop3
                    color: icon_button.color1
                }
               /* PropertyChanges {
                    target: icon_button_background
                    border.width: 5
                }*/
                /*
                PropertyChanges {
                    target: content_image
                    source: icon_button.icon.source
                }
                */

            },
            State {
                when: icon_button.down && icon_button.checked
                name: "pressedChecked"
                PropertyChanges {
                    target: gradientStop1
                    color: icon_button.color3
                }
                PropertyChanges {
                    target: gradientStop2
                    color: icon_button.color3
                }
                PropertyChanges {
                    target: gradientStop3
                    color: icon_button.color1
                }
             /*   PropertyChanges {
                    target: icon_button_background
                    border.width: 1
                }*/
                PropertyChanges {
                    target: content_image
                    source: icon_button.icon.source
                }
            },
            State {
                when: ! icon_button.down && icon_button.checked
                name: "checked"
                PropertyChanges {
                    target: gradientStop1
                    color: icon_button.colorChecked1
                }
                PropertyChanges {
                    target: gradientStop2
                    color: icon_button.colorChecked2
                }
                PropertyChanges {
                    target: gradientStop3
                    color: icon_button.colorChecked3
                }
               /* PropertyChanges {
                    target: icon_button_background
                    border.width: 0
                }*/
                /*
                PropertyChanges {
                    target: content_image
                    source: (icon_button.iconChecked ? icon_button.iconChecked : icon_button.icon.source)
                }
                */
            },
            State {
                when: ! icon_button.down && ! icon_button.checked && ! icon_button.hovered
                name: "up"
                PropertyChanges {
                    target: gradientStop1
                    color: icon_button.color1
                }
                PropertyChanges {
                    target: gradientStop2
                    color: icon_button.color2
                }
                PropertyChanges {
                    target: gradientStop3
                    color: icon_button.color3
                }
                /*PropertyChanges {
                    target: icon_button_background
                    border.width: 0
                }*/
                /*
                PropertyChanges {
                    target: content_image
                    source: icon_button.icon.source
                }
                */
           },
            State {
                when: icon_button.hovered
                name: "hovered"
               /* PropertyChanges {
                    target: icon_button_background
                    border.width: 1
                }*/
                PropertyChanges {
                    target: gradientStop1
                    color: icon_button.colorHover1
                }
                PropertyChanges {
                    target: gradientStop2
                    color: icon_button.colorHover2
                }
                PropertyChanges {
                    target: gradientStop3
                    color: icon_button.colorHover3
                }
                /*
                PropertyChanges {
                    target: content_image
                    source: icon_button.icon.source
                }
                */
            }
        ]


    }
}

//Rectangle {
//    id: iconButtonColor
//    x: 0
//    y: 0
//    width: 120
//    height: 65

//    property color color1: "#ffffff"
//    property color color2: "#ffffff"
//    property color color3: "#ffffff"
//    property url icon: "/images/AutoSteerOn.png"
//    property int bordersize: 3
//    property bool checkable: true
//    property color colorChecked1: "green"
//    property color colorChecked2: "green"
//    property color colorChecked3: "green"
//    property string buttonText: ""
//    property string leftText: ""
//    property string rightText: ""

//    property bool isChecked: false

//    onIsCheckedChanged: {
//        if (isChecked) {
//            gradientStop1.color = colorChecked1
//            gradientStop2.color = colorChecked2
//            gradientStop3.color = colorChecked3
//            //image.source = iconChecked
//        } else {
//            gradientStop1.color = color1
//            gradientStop2.color = color2
//            gradientStop3.color = color3
//            //image.source = icon
//        }
//    }

//    states: [
//        State {
//            when: mouseArea.pressed && !isChecked
//            name: "pressedUnchecked"
//            PropertyChanges {
//                target: gradientStop1
//                color: color3
//            }
//            PropertyChanges {
//                target: gradientStop2
//                color: color3
//            }
//            PropertyChanges {
//                target: gradientStop3
//                color: color1
//            }
//            PropertyChanges {
//                target: iconButtonColor
//                bordersize: 1
//            }
//        },
//        State {
//            when: mouseArea.pressed && isChecked
//            name: "pressedChecked"
//            PropertyChanges {
//                target: gradientStop1
//                color: colorChecked3
//            }
//            PropertyChanges {
//                target: gradientStop2
//                color: colorChecked3
//            }
//            PropertyChanges {
//                target: gradientStop3
//                color: colorChecked1
//            }
//            PropertyChanges {
//                target: iconButtonColor
//                bordersize: 1
//            }
//        },

//        State {
//            when: mouseArea.containsMouse
//            name: "hover"
//            PropertyChanges { target: iconButtonColor; bordersize: 1}
//        }
//    ]

//    signal clicked
//    signal pressAndHold

//    gradient: Gradient {
//        GradientStop {
//            id: gradientStop1
//            position: 0
//            color: iconButtonColor.color1
//        }

//        GradientStop {
//            id: gradientStop2
//            position: 0.5
//            color: iconButtonColor.color2
//        }

//        GradientStop {
//            id: gradientStop3
//            position: 1
//            color: iconButtonColor.color3
//        }
//    }
//    border.width: bordersize
//    Text {
//        id: text1
//        text: parent.buttonText
//        anchors.bottom: parent.top
//        anchors.bottomMargin: 5
//        anchors.left: parent.left
//        font.bold: true
//        font.pixelSize: parent.height * 0.15
//        //z: 1
//    }

//    Image {
//        id: image
//        //x: 50
//        //y: 13
//        width: parent.width
//        //height: parent.height
//        anchors.fill: parent
//        anchors.topMargin: parent.height * 0.05
//        anchors.bottomMargin: parent.height * 0.05
//        anchors.leftMargin: parent.width * 0.05
//        anchors.rightMargin: parent.width * 0.05
//        fillMode: Image.PreserveAspectFit
//        source: parent.icon
//    }

//    MouseArea {
//        id: mouseArea
//        hoverEnabled: true
//        anchors.fill: parent

//        onClicked:{
//            parent.clicked(mouse);
//        }
//        onPressAndHold: {
//            parent.pressAndHold();
//        }
//    }

//    Colorize {
//        id: disableFilter
//        anchors.fill:image
//        source: image
//        hue: 0.0
//        saturation: 0.0
//        lightness: 0.2
//        visible: !parent.enabled
//    }

//}
