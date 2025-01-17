#!/usr/bin/python3

import bs4 #beautifulSoup
import sys
from props import props

add_props = {
    'displayShowBack' : [ 'display/showBack', 
                          'AOGProperty property_displayShowBack("display/showBack",false);',
                          'extern AOGProperty property_displayShowBack;' ]
                          ,
    'antiAliasSamples' : [ 'display/antiAliasSamples',
                           'AOGProperty property_displayAntiAliasSamples("display/antiAliasSamples",0);',
                           'extern AOGProperty property_displayAntiAliasSamples;'],

    'useTrackZero' : [ 'display/useTrackZero',
                    'AOGProperty property_setDisplay_useTrackZero("display/useTrackZero", false);',
                    'extern AOGProperty property_setDisplay_useTrackZero;',
                    'property bool setDisplay_useTrackZero: false',
                    '    addKey(QString("setDisplay_useTrackZero"),QString("display/useTrackZero"));' ],

    'displayTopTrackNum' : [ 'display/topTrackNum',
                             'AOGProperty property_setDisplay_topTrackNum("display/topTrackNum", false);',
                             'extern AOGProperty property_setDisplay_topTrackNum;',
                             'property bool setDisplay_topTrackNum: false',
                             '    addKey(QString("setDisplay_topTrackNum"),QString("display/topTrackNum"));' ],
}

def parse_settings(file):
    cpp = []
    qml_cpp = []
    mock_qml = []
    h = []
    preamble = ['#include "aogproperty.h"','',
                '//Generated by parse_properties.py','']

    with file:
        parser = bs4.BeautifulSoup(file.read(),'lxml-xml')

        settings = parser.findAll('Setting')
        for s in settings: 
            s['Name'] = s['Name'][0].lower() + s['Name'][1:]
            t = s['Type']
            n = s['Name']
            #print (t)
            if t == 'setFeatures':
                #we'll parse these separately
                pass 
            if t == 'System.Int32' or \
               t == 'System.Double' or \
               t == 'system.Decimal' or \
               t == 'System.Byte':
                default_value = s.Value.contents[0]

                #special case for a bad default value in Settings.settings
                if n == 'setVehicle_tankTrailingHitchLength' and default_value[0] != '-':
                    default_value = "-" + default_value

                if t == 'System.Int32' or t == 'system.Byte':
                    mock_qml.append("property int %s: %s" % (n, default_value))
                else:
                    mock_qml.append("property double %s: %s" % (n, default_value))

            elif t == 'System.Boolean':
                default_value = s.Value.contents[0].lower()
                mock_qml.append("property bool %s: %s" % (n, default_value))

            elif t == 'System.String' and n == 'setTool_zones':
                preamble.append('QVector<int> default_zones = { ' + s.Value.contents[0] + ' };')
                mock_qml.append("property var %s: [ %s ]" % (n, s.Value.contents[0]))
                default_value = 'default_zones'
           
            elif t == 'System.String' and n == 'setRelay_pinConfig':
                preamble.append('QVector<int> default_relay_pinConfig = { ' + s.Value.contents[0] + ' };')
                mock_qml.append("property var %s: [ %s ]" % (n, s.Value.contents[0]))
                default_value = 'default_relay_pinConfig'

            elif t == 'System.String' or \
                 t == 'AgOpenGPS.TBrand' or \
                 t == 'AgOpenGPS.HBrand' or \
                 t == 'AgOpenGPS.WDBrand' or \
                 t == 'AgOpenGPS.CFeatureSettings':
                c = s.Value.contents
                if c:
                    default_value = '"' + s.Value.contents[0] + '"'
                else:
                    default_value = '""'
                mock_qml.append("property string %s: %s" % (n, default_value))

            elif t == 'System.Drawing.Point':
                default_value = 'QPoint(%s)' % s.Value.contents[0]
                mock_qml.append("property point %s: \"%s\"" % (n, s.Value.contents[0]))

            elif t == 'System.Drawing.Color':
                fields = s.Value.contents[0].split(',')
                if len(fields) > 1:
                    default_value = 'QColor(%s)' % s.Value.contents[0]
                else:
                    default_value = 'QColor("%s")' % s.Value.contents[0]

                if "," in s.Value.contents[0]:
                    values = s.Value.contents[0].split(',')
                    colorstring = "#%02x%02x%02x" % (int(values[0]), int(values[1]), int(values[2]))
                else:
                    colorstring = s.Value.contents[0]
                mock_qml.append("property string %s: \"%s\"" % (n, colorstring))

            else:
                if s.Value.contents:
                    default_value = '"' + s.Value.contents[0] + '"'
                else:
                    default_value = '""'
                mock_qml.append("property string %s: %s" % (n, default_value))

            if s['Name'] in props:
                qs_name = props[s['Name']]
            else:
                props[s['Name']] = ''
                qs_name = ""

            cpp.append('AOGProperty property_%s("%s",%s);'% (s['Name'], qs_name, default_value))
            qml_cpp.append('    addKey(QString("%s"),QString("%s"));' % (s['Name'], qs_name));
            h.append('extern AOGProperty property_%s;' % s['Name'])

            #preamble.extend(cpp)

    return (preamble, cpp, h, qml_cpp, mock_qml)

def parse_csettings(file):
    cpp = []
    qml_cpp = []
    h = []
    mock_qml = []

    with file:
        for line in file.readlines():
            if 'public bool' in line and 'is' in line:
                line = line.strip()[12:]
                line = line.split(';')[0]
                parts = [x.strip() for x in line.split('=')]
                name = 'setFeature_%s' % parts[0]

                if name in props:
                    qs_name = props[name]
                else:
                    props[name] = 'displayFeatures/%s' % parts[0]
                    qs_name = 'displayFeatures/%s' % parts[0]
                cpp.append('AOGProperty property_%s("%s",%s);'% (name, qs_name, parts[1]))
                qml_cpp.append('    addKey(QString("%s"),QString("%s"));' % (name, qs_name));
                h.append('extern AOGProperty property_%s;' % name)
                mock_qml.append('property bool %s: %s' % (name, parts[1]))

    return ([], cpp, h, qml_cpp, mock_qml)
                



if __name__ == '__main__':
    import argparse

    argparser = argparse.ArgumentParser(prog = sys.argv[0],
                                       description='Parse C# .settings file to create c++ declarations for AOGProperty')
    argparser.add_argument('-c','--cpp', action = "store_true", help = 'Output code for cpp file')
    argparser.add_argument('-q','--qmlcpp', action = "store_true", help = 'Output code for QMLSettings::setupKeys() cpp file')
    argparser.add_argument('-m','--mockqml', action = "store_true", help = 'Output code for MockSettings.qml')
    argparser.add_argument('-i','--header', action = "store_true", help = 'Output header file')
    argparser.add_argument('-d','--dict', action = "store_true", help = 'output python dict of names to help with this script.')

    argparser.add_argument('settings_file', help = 'path to AOG C# Settings.settings file')
    argparser.add_argument('csettings_file', help = 'path to the AOG C# Classes/CSettings.cs file')


    args = argparser.parse_args()
    
    cpp_pre,cpp,h,qml_cpp, mock_qml = parse_settings(open(args.settings_file,'r'))

    cpp_pre1,cpp1,h1,qml_cpp1, mock_qml1 = parse_csettings(open(args.csettings_file,'r'))



    if (args.header):
        print ('#ifndef PROPERTIES_H')
        print ('#define PROPERTIES_H')
        print ()
        print ('#include "aogsettings.h"')
        print ()
        for line in h:
            print (line)

        for line in h1:
            print (line)

        for i in add_props:
            print (add_props[i][2])

        print ()

        print ('#endif // PROPERTIES_H')

    elif args.dict:
        import pprint
        print("props = ", end='')
        pprint.pprint (props, sort_dicts = False)
        
    elif args.mockqml:
        print ("import QtQuick 2.15")
        print ()
        print ("//generated by parse_properties.py -m")
        print ()
        print ("Item {" )
        print ("    id: mockSettings")

        for line in mock_qml:
            print ("    %s"  % line)
        for line in mock_qml1:
            print ("    %s"  % line)
        for key in add_props:
            if len(add_props[key]) > 3:
                print ("    %s"   % add_props[key][3])

        print ("}")

    elif args.qmlcpp:
        print ('#include "qmlsettings.h"')
        print ()
        print ('void QMLSettings::setupKeys() {')
        for line in qml_cpp:
            print (line)
        for line in qml_cpp1:
            print (line)
        for key in add_props:
            if len(add_props[key]) > 4:
                print ("%s"   % add_props[key][4])


        print ('}')



    else: 
        for line in cpp_pre:
            print (line)

        for line in cpp:
            print (line)

        for line in cpp1:
            print (line)

        for i in add_props:
            print(add_props[i][1])

