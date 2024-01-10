import QtQuick 2.0
import Qt.labs.settings 1.1

/* This type contains properties, signals, and functions to interface
   the C++ backend with the QML gui, while abstracting and limiting
   how much the C++ needs to know about the QML structure of the GUI,
   and how much the QML needs to know about the backends.

   This type also exposes the QSettings object for QML to use. However
   there are not change signals in the settings object, so we'll provide
   a signal here to let the backend know QML touched a setting.  Also
   a javascript function here that C++ can call to let QML objects know
   something in settings changed.

*/




Item {
    id: aogInterface

    property double easting: 0
    property double northing: 0
    property double latitude: 0
    property double longitude: 0

    property double imuRollDegrees: 0

    property double speedKph: 0

    property double offlineDistance: 0
    property int lightbarCmPerPixel: 5 //populate from settings
    property bool isLightbarOn: true



    //Signals from GUI to C++ code
    signal blah(bool test)

    //signals from functions to be caught by GUI items



    function deactivateAutoSteer ()
    {


    }

    function deactivateSim ()
    {
    }

    function setHeadland (on: bool)
    {
    }

    /**
     * settings functions
     */

    signal settingChangedCPP(string key) //QML to let c++ know
    signal settingChangedQML(string key) //javascript call this to let qml types know



    //C++ can call this to let QML know about a change. Types will
    //connect themselves to the settingChangedQML() signal
    function settingsUpdated(key: string) {
        settingChangedQML(key)
    }


}