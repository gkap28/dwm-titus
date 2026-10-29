import QtQuick
import Quickshell.Io
import qs.core

ShellButton {
    id: kbd

    property var layouts: ["us", "de", "gr"]
    property string current: "us"

    label: current.toUpperCase()
    accessibleDescription: "Tastatur-Layout: " + current

    onActivated: {
        const i = layouts.indexOf(current);
        const next = layouts[(i + 1) % layouts.length];
        setProc.command = ["setxkbmap", "-layout", next];
        setProc.running = true;
        current = next;
    }

    Process {
        id: setProc
    }

    Process {
        id: queryProc
        command: ["sh", "-c", "setxkbmap -query | awk '/^layout/{print $2}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                const l = this.text.trim().split(",")[0];
                if (l.length > 0) kbd.current = l;
            }
        }
    }

    Component.onCompleted: queryProc.running = true
}
