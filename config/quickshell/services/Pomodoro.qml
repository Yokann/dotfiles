pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property int workDuration: 25 * 60
    readonly property int shortBreakDuration: 5 * 60
    readonly property int longBreakDuration: 15 * 60
    readonly property int cyclesBeforeLongBreak: 4

    property string phase: "work"
    property bool running: false
    property int remainingSeconds: workDuration
    property int completedWorkSessions: 0

    function durationFor(phase: string): int {
        if (phase === "work")
            return root.workDuration;
        if (phase === "longBreak")
            return root.longBreakDuration;
        return root.shortBreakDuration;
    }

    function start(): void {
        root.running = true;
    }

    function pause(): void {
        root.running = false;
    }

    function toggle(): void {
        root.running = !root.running;
    }

    function reset(): void {
        root.running = false;
        root.remainingSeconds = root.durationFor(root.phase);
    }

    function skip(): void {
        _advancePhase();
    }

    function _labelFor(phase: string): string {
        if (phase === "work")
            return "Work session";
        if (phase === "longBreak")
            return "Long break";
        return "Short break";
    }

    function _notifyPhaseEnd(): void {
        const endingLabel = root._labelFor(root.phase);
        const nextPhase = root.phase === "work"
            ? ((root.completedWorkSessions + 1) % root.cyclesBeforeLongBreak === 0 ? "longBreak" : "shortBreak")
            : "work";
        notifyProcess.command = ["notify-send", "-a", "Pomodoro", `${endingLabel} finished`, `Next up: ${root._labelFor(nextPhase)}`];
        notifyProcess.running = true;
    }

    function _advancePhase(): void {
        if (root.phase === "work") {
            root.completedWorkSessions++;
            root.phase = (root.completedWorkSessions % root.cyclesBeforeLongBreak === 0) ? "longBreak" : "shortBreak";
        } else {
            root.phase = "work";
        }
        root.remainingSeconds = root.durationFor(root.phase);
    }

    // Not refCount-gated like the polling services: the countdown is meant to keep
    // running in the background regardless of whether a widget instance currently
    // renders it, only `running` (user-controlled) gates the tick.
    Timer {
        interval: 1000
        running: root.running
        repeat: true
        onTriggered: {
            if (root.remainingSeconds > 0) {
                root.remainingSeconds--;
            } else {
                root._notifyPhaseEnd();
                root._advancePhase();
            }
        }
    }

    Process { id: notifyProcess }
}
