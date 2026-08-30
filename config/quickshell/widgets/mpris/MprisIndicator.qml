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

    readonly property string label: root.player
    ? `${root.player.isPlaying ? "▶" : "⏸"} ${root.player.identity} - ${root.player.trackArtist} - ${root.player.trackTitle}`
    : ""

    visible: root.player !== null
    implicitWidth: root.player ? button.implicitWidth : 0
    implicitHeight: root.player ? button.implicitHeight : 0

    WidgetButton {
        id: button
        anchors.fill: parent
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
