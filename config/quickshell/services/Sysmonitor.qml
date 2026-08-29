pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int refCount: 0
    property real cpuUsage: 0
    property real memUsage: 0
    property real diskUsage: 0

    property var _prevCpu: null

    function poll(): void {
        statsProcess.running = true;
    }

    Process {
        id: statsProcess
        command: ["sh", "-c", "cat /proc/stat | head -1; echo SPLIT; grep -E '^(MemTotal|MemAvailable):' /proc/meminfo; echo SPLIT; df -h --output=pcent / | tail -1"]

        stdout: StdioCollector {
            onStreamFinished: {
                const [cpuPart, memPart, diskPart] = text.split("SPLIT").map(s => s.trim());

                const cpuFields = cpuPart.trim().split(/\s+/).slice(1).map(Number);
                const idle = cpuFields[3] + cpuFields[4];
                const total = cpuFields.reduce((sum, field) => sum + field, 0);
                if (root._prevCpu) {
                    const totalDelta = total - root._prevCpu.total;
                    const idleDelta = idle - root._prevCpu.idle;
                    if (totalDelta > 0)
                        root.cpuUsage = Math.max(0, Math.min(100, 100 * (1 - idleDelta / totalDelta)));
                }
                root._prevCpu = { total, idle };

                const memValues = {};
                for (const line of memPart.split("\n")) {
                    const match = line.match(/^(\w+):\s+(\d+)/);
                    if (match)
                        memValues[match[1]] = Number(match[2]);
                }
                root.memUsage = memValues.MemTotal ? 100 * (1 - memValues.MemAvailable / memValues.MemTotal) : 0;

                root.diskUsage = Number(diskPart.replace("%", "")) || 0;
            }
        }
    }

    Timer {
        interval: 2000
        running: root.refCount > 0
        repeat: true
        triggeredOnStart: true
        onTriggered: root.poll()
    }
}
