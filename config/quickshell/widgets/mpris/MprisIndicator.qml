import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import qs.theme
import qs.ui

BarWidget {
    id: root

    readonly property MprisPlayer player: {
        const players = Mpris.players.values;
        return players.find(p => p.isPlaying) ?? players[0] ?? null;
    }

    readonly property string icon: root.player?.isPlaying ? "▶" : "⏸"
    readonly property string collapsedLabel: root.player ? `${root.icon} ${root.player.trackTitle}` : ""
    readonly property string expandedLabel: root.player ? `${root.icon} ${root.player.identity} - ${root.player.trackArtist} - ${root.player.trackTitle}` : ""
    readonly property string label: button.hovered ? root.expandedLabel : root.collapsedLabel

    visible: root.player !== null
    implicitWidth: root.player ? button.implicitWidth : 0
    implicitHeight: root.player ? button.implicitHeight : 0

    Behavior on implicitWidth {
        NumberAnimation { duration: button.style.hoverDurationMs; easing.type: Easing.OutCubic }
    }

    WidgetButton {
        id: button
        anchors.fill: parent
        clip: true
        styleOverrides: root.resolveStyle({})

        onClicked: if (root.player?.canTogglePlaying)
        root.player.togglePlaying()

        Text {
            text: root.label
            color: button.resolvedTextColor
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
        }
    }
}
