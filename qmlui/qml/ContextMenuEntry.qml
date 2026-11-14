/*
  Q Light Controller Plus
  ContextMenuEntry.qml

  Copyright (c) Massimo Callegari

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0.txt

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import QtQuick

import "."

Rectangle
{
    id: baseMenuEntry
    width: parent ? (parent.width > itemWidth) ? parent.width : itemWidth : 400
    implicitWidth: itemWidth
    height: iconHeight + 6

    property string imgSource: ""
    property string entryText: ""
    property string faSource: ""
    property color faColor: UISettings.fgMain
    property color bgColor: "transparent"
    property color hoverColor: UISettings.highlight
    property color pressColor: UISettings.highlightPressed

    property int iconHeight: UISettings.iconSizeDefault
    property int iconWidth: iconHeight
    /* The entry keeps the height its icon asks for, and the icon is drawn
       inside it as tall as the text, with air around: at full height it
       was twice the size of the text and the entries looked piled up */
    readonly property int drawnIconHeight: Math.min(iconHeight, Math.round(UISettings.textSizeDefault))
    readonly property int drawnIconWidth: iconHeight > 0 ? Math.round(iconWidth * drawnIconHeight / iconHeight) : 0
    property int sidePadding: 10
    property int itemWidth: entryRow.width + 20

    signal clicked
    signal entered
    signal exited

    color: bgColor
    border.color: UISettings.bgLight
    border.width: 1

    states: [
        State
        {
            when: entryMouseArea.pressed
            PropertyChanges
            {
                target: baseMenuEntry
                color: pressColor
            }
        },
        State
        {
            when: entryMouseArea.containsMouse
            PropertyChanges
            {
                target: baseMenuEntry
                color: hoverColor
            }
        }
    ]

    Row
    {
        id: entryRow
        x: sidePadding
        height: parent.height
        spacing: sidePadding

        Image
        {
            visible: imgSource ? true : false
            anchors.verticalCenter: parent.verticalCenter
            height: drawnIconHeight
            width: drawnIconWidth
            source: imgSource
            sourceSize: Qt.size(width, height)
        }

        Text
        {
            visible: faSource ? true : false
            width: drawnIconHeight
            color: faColor
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: UISettings.fontAwesomeFontName
            font.pixelSize: drawnIconHeight
            text: faSource
        }

        RobotoText
        {
            label: entryText
            height: baseMenuEntry.height
            fontSize: UISettings.textSizeDefault
            fontBold: true
        }
    }

    MouseArea
    {
        id: entryMouseArea
        anchors.fill: parent
        hoverEnabled: baseMenuEntry.visible
        onEntered: baseMenuEntry.entered()
        onExited: baseMenuEntry.exited()
        onReleased: baseMenuEntry.clicked()
    }

    Rectangle
    {
        anchors.fill: parent
        color: "black"
        opacity: 0.6
        visible: !parent.enabled
    }
}
