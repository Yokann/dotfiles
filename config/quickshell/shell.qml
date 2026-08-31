//@ pragma UseQApplication

import Quickshell
import qs.config
import "modules/bar"
import "modules/submap"

ShellRoot {
    Variants {
        model: Settings.bars

        Bar {
            required property var modelData
            barConfig: modelData
        }
    }

    SubmapIndicator {}
}
