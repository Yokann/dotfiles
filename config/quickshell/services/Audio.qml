pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool sinkMuted: sink?.audio?.muted ?? false
    readonly property real sinkVolume: sink?.audio?.volume ?? 0
    readonly property bool sourceMuted: source?.audio?.muted ?? false
    readonly property real sourceVolume: source?.audio?.volume ?? 0

    readonly property var sinks: Pipewire.nodes.values.filter(n => n.audio && n.isSink && !n.isStream)
    readonly property var sources: Pipewire.nodes.values.filter(n => n.audio && !n.isSink && !n.isStream)

    function setSinkVolume(volume: real): void {
        if (sink?.ready && sink?.audio)
            sink.audio.volume = Math.max(0, Math.min(1, volume));
    }

    function setSourceVolume(volume: real): void {
        if (source?.ready && source?.audio)
            source.audio.volume = Math.max(0, Math.min(1, volume));
    }

    function toggleSinkMute(): void {
        if (sink?.ready && sink?.audio)
            sink.audio.muted = !sink.audio.muted;
    }

    function toggleSourceMute(): void {
        if (source?.ready && source?.audio)
            source.audio.muted = !source.audio.muted;
    }

    function selectSink(node: PwNode): void {
        Pipewire.preferredDefaultAudioSink = node;
    }

    function selectSource(node: PwNode): void {
        Pipewire.preferredDefaultAudioSource = node;
    }

    PwObjectTracker {
        objects: Pipewire.nodes.values.filter(n => n.audio)
    }
}
