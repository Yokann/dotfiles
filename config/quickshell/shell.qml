//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import qs.config
import "modules/bar"
import "modules/panel"
import "modules/submap"

ShellRoot {
    Variants {
        id: bars

        model: Settings.bars

        Bar {
            required property var modelData
            barConfig: modelData
        }
    }

    Variants {
        id: panels

        model: Settings.panels

        PanelInstance {
            required property var modelData
            panelConfig: modelData
        }
    }

    IpcHandler {
        target: "bar-all"

        function toggle(): void {
            for (const bar of bars.instances)
                bar.barVisible = !bar.barVisible;
        }

        function reveal(): void {
            for (const bar of bars.instances)
                bar.barVisible = true;
        }

        function hide(): void {
            for (const bar of bars.instances)
                bar.barVisible = false;
        }

        function isVisible(): bool {
            return bars.instances.every(bar => bar.barVisible);
        }
    }

    SubmapIndicator {}
}
