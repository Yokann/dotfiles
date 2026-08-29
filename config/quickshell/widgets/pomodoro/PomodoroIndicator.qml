import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Pill {
    id: root

    readonly property string label: {
        const m = Math.floor(Pomodoro.remainingSeconds / 60);
        const s = Pomodoro.remainingSeconds % 60;
        return ` ${m}:${s.toString().padStart(2, "0")}`;
    }

    Text {
        text: root.label
        color: Pomodoro.phase === "work" ? Colors.text : Colors.green
        font.family: Metrics.fontFamily
        font.pixelSize: Metrics.fontSize
        font.weight: root.style.fontWeight
        opacity: Pomodoro.running ? 1 : 0.6
    }

    onClicked: popupLoader.item.visible = !popupLoader.item.visible

    LazyLoader {
        id: popupLoader
        loading: true

        PomodoroPopup {
            anchor.item: root
        }
    }
}
