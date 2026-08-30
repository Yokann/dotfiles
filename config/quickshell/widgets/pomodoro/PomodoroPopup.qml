import QtQuick
import Quickshell
import qs.theme
import qs.ui
import qs.services

Popup {
    id: root

    implicitWidth: 220
    implicitHeight: 140
    visible: false
    grabFocus: true

    readonly property string phaseLabel: {
        if (Pomodoro.phase === "work")
        return "Working time";
        if (Pomodoro.phase === "longBreak")
        return "Long break";
        return "Short break";
    }

    readonly property string timeLabel: {
        const m = Math.floor(Pomodoro.remainingSeconds / 60);
        const s = Pomodoro.remainingSeconds % 60;
        return `${m}:${s.toString().padStart(2, "0")}`;
    }

    readonly property color phaseColor: Pomodoro.phase === "work" ? Colors.accent : Colors.green

    Column {
        anchors.fill: parent
        spacing: Metrics.spacingMedium

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: root.phaseLabel
            color: root.phaseColor
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize
            font.bold: true
        }

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: root.timeLabel
            color: Colors.text
            font.family: Metrics.fontFamily
            font.pixelSize: Metrics.fontSize * 2
        }

        ProgressBar {
            width: parent.width
            value: Pomodoro.remainingSeconds / Pomodoro.durationFor(Pomodoro.phase)
            fillColor: root.phaseColor
        }

        Item {
            width: parent.width
            height: controlsRow.implicitHeight

            Row {
                id: controlsRow
                anchors.centerIn: parent
                spacing: Metrics.spacingLarge

                Text {
                    text: Pomodoro.running ? "⏸" : "▶"
                    color: Colors.text
                    font.pixelSize: Metrics.fontSize + 4

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Pomodoro.toggle()
                    }
                }

                Text {
                    text: "↺"
                    color: Colors.subtext0
                    font.pixelSize: Metrics.fontSize + 4

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Pomodoro.reset()
                    }
                }

                Text {
                    text: "⏭"
                    color: Colors.subtext0
                    font.pixelSize: Metrics.fontSize + 4

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Pomodoro.skip()
                    }
                }
            }
        }
    }
}
