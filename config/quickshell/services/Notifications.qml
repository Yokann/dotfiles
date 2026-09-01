pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int count: 0
    property bool dnd: false

    Process {
        id: subscribeProcess
        command: ["swaync-client", "-s"]
        running: true

        stdout: SplitParser {
            splitMarker: "\n"

            onRead: data => {
                if (!data.trim())
                    return;
                const state = JSON.parse(data);
                root.count = Number(state.text) || 0;
                root.dnd = (state.alt ?? "").startsWith("dnd");
            }
        }

        onExited: restartTimer.restart()
    }

    // swaync-client -swb is a long-running subscription, not a one-shot query - if
    // swaync itself restarts and the subscriber dies with it, respawn after a short
    // delay rather than leaving the indicator silently frozen on stale state.
    Timer {
        id: restartTimer
        interval: 2000
        onTriggered: subscribeProcess.running = true
    }
}
