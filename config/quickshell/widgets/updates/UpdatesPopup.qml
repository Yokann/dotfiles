import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Popup {
    id: root

    implicitWidth: 300
    implicitHeight: 320
    scrollContentHeight: content.implicitHeight
    visible: false
    grabFocus: true

    anchor.edges: Edges.Bottom | Edges.Left
    anchor.margins.top: Metrics.spacingSmall

    Column {
        id: content

        width: parent.width
        spacing: Metrics.spacingMedium

        Row {
            width: parent.width
            height: refreshLabel.implicitHeight

            Text {
                width: parent.width - 48
                text: Updates.count > 0 ? `${Updates.count} update(s)` : "Up to date"
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize
                font.bold: true
            }

            Text {
                id: updateLabel
                width: 24
                horizontalAlignment: Text.AlignRight
                text: "⇧"
                color: Updates.count > 0 ? Colors.yellow : Colors.subtext0
                font.pixelSize: Metrics.fontSize

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Updates.runUpdate()
                }
            }

            Text {
                id: refreshLabel
                width: 24
                horizontalAlignment: Text.AlignRight
                text: Updates.checking ? "…" : "⟳"
                color: Colors.subtext0
                font.pixelSize: Metrics.fontSize

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Updates.poll()
                }
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall / 2

            Repeater {
                model: Updates.packages

                delegate: Column {
                    required property var modelData

                    width: parent.width

                    Text {
                        width: parent.width
                        text: modelData.name
                        color: Colors.text
                        font.family: Metrics.fontFamily
                        font.pixelSize: Metrics.fontSize
                        elide: Text.ElideRight
                    }

                    Text {
                        width: parent.width
                        text: `${modelData.oldVersion} → ${modelData.newVersion}`
                        color: Colors.subtext0
                        font.family: Metrics.fontFamily
                        font.pixelSize: Metrics.fontSize - 2
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}
