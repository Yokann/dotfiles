import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

BarWidget {
    id: root

    readonly property string label: {
        const m = Math.floor(Pomodoro.remainingSeconds / 60);
        const s = Pomodoro.remainingSeconds % 60;
        return `${m}:${s.toString().padStart(2, "0")}`;
    }

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    WidgetButton {
        id: button
        anchors.fill: parent
        styleOverrides: root.resolveStyle({})

        onClicked: popupLoader.item.visible = !popupLoader.item.visible

        Text {
            text: ""
            color: "red"
            font.pixelSize: Metrics.fontSize
        }
        Text {
            text: root.label
            color: Pomodoro.phase === "work" ? Colors.text : Colors.green
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.weight: button.style.fontWeight
            opacity: Pomodoro.running ? 1 : 0.6
        }

        LazyLoader {
            id: popupLoader
            loading: true

            PomodoroPopup {
                anchor.item: root
            }
        }
    }
}
