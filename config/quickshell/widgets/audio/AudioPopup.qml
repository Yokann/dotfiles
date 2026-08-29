import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Popup {
    id: root

    implicitWidth: 360
    implicitHeight: 150
    scrollContentHeight: content.implicitHeight
    visible: false
    grabFocus: true

    anchor.edges: Edges.Bottom | Edges.Left
    anchor.margins.top: Metrics.spacingSmall

    Column {
        id: content

        width: parent.width
        spacing: Metrics.spacingMedium

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall

            Text {
                text: Audio.sinkMuted ? "Output (muted)" : "Output"
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Audio.toggleSinkMute()
                }
            }

            Slider {
                width: parent.width
                value: Audio.sinkVolume
                onMoved: volume => Audio.setSinkVolume(volume)
            }

            Dropdown {
                width: parent.width
                currentLabel: Audio.sink ? (Audio.sink.description || Audio.sink.name) : "—"
                options: Audio.sinks.map(node => ({
                            label: node.description || node.name,
                            value: node,
                            isCurrent: node.id === Audio.sink?.id
                }))
                onSelected: node => Audio.selectSink(node)
            }
        }

        Column {
            width: parent.width
            spacing: Metrics.spacingSmall

            Text {
                text: Audio.sourceMuted ? "Micro (muted)" : "Micro"
                color: Colors.text
                font.family: Metrics.fontFamily
                font.pixelSize: Metrics.fontSize

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Audio.toggleSourceMute()
                }
            }

            Slider {
                width: parent.width
                value: Audio.sourceVolume
                onMoved: volume => Audio.setSourceVolume(volume)
            }

            Dropdown {
                width: parent.width
                currentLabel: Audio.source ? (Audio.source.description || Audio.source.name) : "—"
                options: Audio.sources.map(node => ({
                            label: node.description || node.name,
                            value: node,
                            isCurrent: node.id === Audio.source?.id
                }))
                onSelected: node => Audio.selectSource(node)
            }
        }
    }
}
