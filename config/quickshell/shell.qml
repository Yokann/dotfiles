//@ pragma UseQApplication

import Quickshell
import qs.config
import "modules/bar"

ShellRoot {
    Variants {
        model: Settings.bars

        Bar {
            required property var modelData
            barConfig: modelData
        }
    }
}
