import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                left: true
                right: true
                top: true
            }
            implicitHeight: 30
            color: "#1e1e2e"

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4

                Repeater {
                    model: Hyprland.workspaces

                    delegate: Rectangle {
                        required property HyprlandWorkspace modelData

                        width: 24
                        height: 24
                        radius: 4
                        color: modelData.active ? "#89b4fa" : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: modelData.name
                            color: modelData.active ? "#1e1e2e" : "#cdd6f4"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("workspace " + modelData.name)
                        }
                    }
                }
            }

            SystemClock {
                id: clock
                precision: SystemClock.Minutes
            }

            Text {
                anchors.centerIn: parent
                color: "#cdd6f4"
                text: Qt.formatDateTime(clock.date, "hh:mm")
            }

            Process {
                id: brightnessQuery
                command: ["brightnessctl", "-m", "-d", "intel_backlight"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        // acpi_video0,backlight,<raw>,<percent>%,<max>
                        var parts = text.trim().split(",");
                        if (parts.length >= 4) {
                            var pct = parseInt(parts[3]);
                            if (!isNaN(pct))
                                brightnessTrack.settledFraction = pct / 100;
                        }
                    }
                }
            }

            Process {
                id: brightnessSet
                onExited: brightnessQuery.running = true
            }

            Process {
                id: kbdBrightnessQuery
                command: ["brightnessctl", "-m", "-d", "system76_acpi::kbd_backlight"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        var parts = text.trim().split(",");
                        if (parts.length >= 4) {
                            var pct = parseInt(parts[3]);
                            if (!isNaN(pct)) {
                                var floor = kbdBrightnessTrack.minPercent;
                                var offZone = kbdBrightnessTrack.offZoneFraction;
                                var frac;
                                if (pct <= 0) {
                                    frac = 0;
                                } else {
                                    var clamped = Math.max(pct, floor);
                                    frac = offZone + (clamped - floor) / (100 - floor) * (1 - offZone);
                                }
                                kbdBrightnessTrack.settledFraction = Math.max(0, Math.min(1, frac));
                            }
                        }
                    }
                }
            }

            Process {
                id: kbdBrightnessSet
                onExited: kbdBrightnessQuery.running = true
            }

            PwObjectTracker {
                objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] : []
            }

            Timer {
                interval: 5000
                running: true
                repeat: true
                onTriggered: {
                    brightnessQuery.running = true;
                    kbdBrightnessQuery.running = true;
                }
            }

            Component.onCompleted: {
                brightnessQuery.running = true;
                kbdBrightnessQuery.running = true;
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                Rectangle {
                    id: backlightButton

                    width: 24
                    height: 24
                    radius: 4
                    color: backlightMenu.requestOpen ? "#89b4fa" : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "🔆"
                        color: backlightMenu.requestOpen ? "#1e1e2e" : "#cdd6f4"
                    }

                    HoverHandler {
                        id: backlightButtonHover
                        onHoveredChanged: backlightMenuCloseTimer.restart()
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: backlightMenu.requestOpen = !backlightMenu.requestOpen
                    }
                }

                Rectangle {
                    id: volumeButton

                    readonly property var sinkAudio: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null

                    width: volumeText.implicitWidth + 12
                    height: 24
                    radius: 4
                    color: volumeMenu.requestOpen ? "#89b4fa" : "transparent"

                    Text {
                        id: volumeText
                        anchors.centerIn: parent
                        color: volumeMenu.requestOpen ? "#1e1e2e" : "#cdd6f4"
                        text: {
                            if (!volumeButton.sinkAudio)
                                return "🔈 --";
                            if (volumeButton.sinkAudio.muted)
                                return "🔇";
                            var icon = volumeButton.sinkAudio.volume > 0.5 ? "🔊" : (volumeButton.sinkAudio.volume > 0 ? "🔉" : "🔈");
                            return icon + " " + Math.round(volumeButton.sinkAudio.volume * 100) + "%";
                        }
                    }

                    HoverHandler {
                        id: volumeButtonHover
                        onHoveredChanged: volumeMenuCloseTimer.restart()
                    }

                    WheelHandler {
                        onWheel: event => {
                            if (!volumeButton.sinkAudio)
                                return;
                            var step = event.angleDelta.y > 0 ? 0.05 : -0.05;
                            volumeButton.sinkAudio.volume = Math.max(0, Math.min(1, volumeButton.sinkAudio.volume + step));
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.MiddleButton) {
                                if (volumeButton.sinkAudio)
                                    volumeButton.sinkAudio.muted = !volumeButton.sinkAudio.muted;
                            } else {
                                volumeMenu.requestOpen = !volumeMenu.requestOpen;
                            }
                        }
                    }
                }

                Rectangle {
                    id: bluetoothButton

                    readonly property var adapter: Bluetooth.defaultAdapter

                    width: 24
                    height: 24
                    radius: 4
                    color: bluetoothMenu.requestOpen ? "#89b4fa" : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "BT"
                        color: bluetoothMenu.requestOpen ? "#1e1e2e" : "#cdd6f4"
                    }

                    HoverHandler {
                        id: bluetoothButtonHover
                        onHoveredChanged: bluetoothMenuCloseTimer.restart()
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.MiddleButton) {
                                if (bluetoothButton.adapter)
                                    bluetoothButton.adapter.enabled = !bluetoothButton.adapter.enabled;
                            } else {
                                bluetoothMenu.requestOpen = !bluetoothMenu.requestOpen;
                            }
                        }
                    }
                }

                Rectangle {
                    id: powerProfile

                    width: profileText.implicitWidth + 12
                    height: 24
                    radius: 4
                    color: profileMouse.containsMouse ? "#313244" : "transparent"

                    Text {
                        id: profileText
                        anchors.centerIn: parent
                        color: "#cdd6f4"
                        text: {
                            var icon = "🔋";
                            if (PowerProfiles.profile === PowerProfile.Balanced)
                                icon = "⚖";
                            else if (PowerProfiles.profile === PowerProfile.Performance)
                                icon = "⚡";
                            return icon + " " + Math.round(UPower.displayDevice.percentage * 100) + "%";
                        }
                    }

                    MouseArea {
                        id: profileMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (PowerProfiles.profile === PowerProfile.PowerSaver)
                                PowerProfiles.profile = PowerProfile.Balanced;
                            else if (PowerProfiles.profile === PowerProfile.Balanced)
                                PowerProfiles.profile = PowerProfile.Performance;
                            else
                                PowerProfiles.profile = PowerProfile.PowerSaver;
                        }
                    }
                }

                Rectangle {
                    id: powerButton

                    width: 24
                    height: 24
                    radius: 4
                    color: powerMenu.visible ? "#89b4fa" : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "⏻"
                        color: powerMenu.visible ? "#1e1e2e" : "#cdd6f4"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: powerMenu.visible = !powerMenu.visible
                    }
                }
            }

            PopupWindow {
                id: backlightMenu

                property bool requestOpen: false

                visible: requestOpen || contentRect.opacity > 0
                color: "transparent"

                anchor.item: backlightButton
                anchor.edges: Edges.Bottom | Edges.Right
                anchor.gravity: Edges.Bottom | Edges.Left
                anchor.margins.top: 4

                implicitWidth: 180
                implicitHeight: sliderColumn.implicitHeight + 16

                Timer {
                    id: backlightMenuCloseTimer
                    interval: 300
                    onTriggered: {
                        if (!backlightButtonHover.hovered && !backlightMenuHover.hovered
                                && !brightnessTrack.dragging && !kbdBrightnessTrack.dragging)
                            backlightMenu.requestOpen = false;
                    }
                }

                Rectangle {
                    id: contentRect

                    anchors.fill: parent
                    color: "#1e1e2e"
                    radius: 6
                    border.color: "#313244"
                    border.width: 1
                    opacity: backlightMenu.requestOpen ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 150 }
                    }

                    HoverHandler {
                        id: backlightMenuHover
                        onHoveredChanged: backlightMenuCloseTimer.restart()
                    }

                    Column {
                        id: sliderColumn

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 12

                        Row {
                            width: parent.width
                            spacing: 8

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "🔆"
                                color: "#cdd6f4"
                            }

                            Item {
                                id: brightnessTrack

                                property bool dragging: false
                                property real dragFraction: 0
                                property real settledFraction: 0
                                property real fraction: dragging ? dragFraction : settledFraction

                                width: parent.width - 24
                                height: 24
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.width
                                    height: 8
                                    radius: 4
                                    color: "#313244"

                                    Rectangle {
                                        width: parent.width * brightnessTrack.fraction
                                        height: parent.height
                                        radius: 4
                                        color: "#89b4fa"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent

                                    function updateDrag(x) {
                                        brightnessTrack.dragFraction = Math.max(0, Math.min(1, x / brightnessTrack.width));
                                    }

                                    onPressed: mouse => {
                                        brightnessTrack.dragging = true;
                                        updateDrag(mouse.x);
                                    }
                                    onPositionChanged: mouse => {
                                        if (pressed)
                                            updateDrag(mouse.x);
                                    }
                                    onReleased: {
                                        brightnessTrack.dragging = false;
                                        brightnessTrack.settledFraction = brightnessTrack.dragFraction;
                                        brightnessSet.command = ["brightnessctl", "-d", "intel_backlight", "set", Math.round(brightnessTrack.dragFraction * 100) + "%"];
                                        brightnessSet.running = true;
                                    }
                                }
                            }
                        }

                        Row {
                            width: parent.width
                            spacing: 8

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "⌨"
                                color: "#cdd6f4"
                            }

                            Item {
                                id: kbdBrightnessTrack

                                // below this, the keyboard LED is visibly off despite brightnessctl
                                // reporting a nonzero value; scale the slider to the visible range,
                                // reserving a small zone at the left for true off
                                readonly property real minPercent: 50
                                readonly property real offZoneFraction: 0.12

                                property bool dragging: false
                                property real dragFraction: 0
                                property real settledFraction: 0
                                property real fraction: dragging ? dragFraction : settledFraction

                                width: parent.width - 24
                                height: 24
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.width
                                    height: 8
                                    radius: 4
                                    color: "#313244"

                                    Rectangle {
                                        width: parent.width * kbdBrightnessTrack.fraction
                                        height: parent.height
                                        radius: 4
                                        color: "#89b4fa"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent

                                    function updateDrag(x) {
                                        kbdBrightnessTrack.dragFraction = Math.max(0, Math.min(1, x / kbdBrightnessTrack.width));
                                    }

                                    onPressed: mouse => {
                                        kbdBrightnessTrack.dragging = true;
                                        updateDrag(mouse.x);
                                    }
                                    onPositionChanged: mouse => {
                                        if (pressed)
                                            updateDrag(mouse.x);
                                    }
                                    onReleased: {
                                        kbdBrightnessTrack.dragging = false;
                                        kbdBrightnessTrack.settledFraction = kbdBrightnessTrack.dragFraction;
                                        var floor = kbdBrightnessTrack.minPercent;
                                        var offZone = kbdBrightnessTrack.offZoneFraction;
                                        var pct;
                                        if (kbdBrightnessTrack.dragFraction < offZone) {
                                            pct = 0;
                                        } else {
                                            var remapped = (kbdBrightnessTrack.dragFraction - offZone) / (1 - offZone);
                                            pct = Math.round(floor + remapped * (100 - floor));
                                        }
                                        kbdBrightnessSet.command = ["brightnessctl", "-d", "system76_acpi::kbd_backlight", "set", pct + "%"];
                                        kbdBrightnessSet.running = true;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: volumeMenu

                property bool requestOpen: false

                visible: requestOpen || volumeContentRect.opacity > 0
                color: "transparent"

                anchor.item: volumeButton
                anchor.edges: Edges.Bottom | Edges.Right
                anchor.gravity: Edges.Bottom | Edges.Left
                anchor.margins.top: 4

                implicitWidth: 260
                implicitHeight: volumeColumn.implicitHeight + 16

                Timer {
                    id: volumeMenuCloseTimer
                    interval: 300
                    onTriggered: {
                        if (!volumeButtonHover.hovered && !volumeMenuHover.hovered && !volumeTrack.dragging)
                            volumeMenu.requestOpen = false;
                    }
                }

                Rectangle {
                    id: volumeContentRect

                    anchors.fill: parent
                    color: "#1e1e2e"
                    radius: 6
                    border.color: "#313244"
                    border.width: 1
                    opacity: volumeMenu.requestOpen ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 150 }
                    }

                    HoverHandler {
                        id: volumeMenuHover
                        onHoveredChanged: volumeMenuCloseTimer.restart()
                    }

                    Column {
                        id: volumeColumn

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 12

                        Row {
                            width: parent.width
                            spacing: 8

                            Rectangle {
                                width: 24
                                height: 24
                                radius: 4
                                color: muteMouse.containsMouse ? "#313244" : "transparent"

                                Text {
                                    anchors.centerIn: parent
                                    text: (volumeButton.sinkAudio && volumeButton.sinkAudio.muted) ? "🔇" : "🔊"
                                    color: "#cdd6f4"
                                }

                                MouseArea {
                                    id: muteMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        if (volumeButton.sinkAudio)
                                            volumeButton.sinkAudio.muted = !volumeButton.sinkAudio.muted;
                                    }
                                }
                            }

                            Item {
                                id: volumeTrack

                                property bool dragging: false
                                property real dragFraction: 0
                                property real settledFraction: volumeButton.sinkAudio ? Math.min(1, volumeButton.sinkAudio.volume) : 0
                                property real fraction: dragging ? dragFraction : settledFraction

                                width: parent.width - 24
                                height: 24
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.width
                                    height: 8
                                    radius: 4
                                    color: "#313244"

                                    Rectangle {
                                        width: parent.width * volumeTrack.fraction
                                        height: parent.height
                                        radius: 4
                                        color: "#89b4fa"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent

                                    function updateDrag(x) {
                                        volumeTrack.dragFraction = Math.max(0, Math.min(1, x / volumeTrack.width));
                                    }

                                    onPressed: mouse => {
                                        volumeTrack.dragging = true;
                                        updateDrag(mouse.x);
                                    }
                                    onPositionChanged: mouse => {
                                        if (pressed)
                                            updateDrag(mouse.x);
                                    }
                                    onReleased: {
                                        volumeTrack.dragging = false;
                                        volumeTrack.settledFraction = volumeTrack.dragFraction;
                                        if (volumeButton.sinkAudio)
                                            volumeButton.sinkAudio.volume = volumeTrack.dragFraction;
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#313244"
                        }

                        Repeater {
                            model: Pipewire.nodes.values.filter(n => n.isSink && !n.isStream)

                            delegate: Rectangle {
                                required property var modelData

                                width: volumeColumn.width
                                height: 28
                                radius: 4
                                color: {
                                    if (modelData === Pipewire.defaultAudioSink)
                                        return "#89b4fa";
                                    return outputMouse.containsMouse ? "#313244" : "transparent";
                                }

                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 8
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    elide: Text.ElideRight
                                    color: modelData === Pipewire.defaultAudioSink ? "#1e1e2e" : "#cdd6f4"
                                    text: modelData.description || modelData.name
                                }

                                MouseArea {
                                    id: outputMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: Pipewire.preferredDefaultAudioSink = modelData
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: bluetoothMenu

                property bool requestOpen: false

                visible: requestOpen || bluetoothContentRect.opacity > 0
                color: "transparent"

                anchor.item: bluetoothButton
                anchor.edges: Edges.Bottom | Edges.Right
                anchor.gravity: Edges.Bottom | Edges.Left
                anchor.margins.top: 4

                implicitWidth: 260
                implicitHeight: bluetoothColumn.implicitHeight + 16

                Timer {
                    id: bluetoothMenuCloseTimer
                    interval: 300
                    onTriggered: {
                        if (!bluetoothButtonHover.hovered && !bluetoothMenuHover.hovered)
                            bluetoothMenu.requestOpen = false;
                    }
                }

                Rectangle {
                    id: bluetoothContentRect

                    anchors.fill: parent
                    color: "#1e1e2e"
                    radius: 6
                    border.color: "#313244"
                    border.width: 1
                    opacity: bluetoothMenu.requestOpen ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 150 }
                    }

                    HoverHandler {
                        id: bluetoothMenuHover
                        onHoveredChanged: bluetoothMenuCloseTimer.restart()
                    }

                    Column {
                        id: bluetoothColumn

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Rectangle {
                            width: parent.width
                            height: 28
                            radius: 4
                            color: powerToggleMouse.containsMouse ? "#313244" : "transparent"

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                color: "#cdd6f4"
                                text: "Bluetooth"
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                color: (bluetoothButton.adapter && bluetoothButton.adapter.enabled) ? "#a6e3a1" : "#f38ba8"
                                text: (bluetoothButton.adapter && bluetoothButton.adapter.enabled) ? "On" : "Off"
                            }

                            MouseArea {
                                id: powerToggleMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (bluetoothButton.adapter)
                                        bluetoothButton.adapter.enabled = !bluetoothButton.adapter.enabled;
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#313244"
                        }

                        Repeater {
                            model: bluetoothButton.adapter ? bluetoothButton.adapter.devices.values.filter(d => d.paired) : []

                            delegate: Rectangle {
                                required property var modelData

                                width: bluetoothColumn.width
                                height: 32
                                radius: 4
                                color: modelData.connected ? "#89b4fa" : (deviceMouse.containsMouse ? "#313244" : "transparent")

                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 8
                                    anchors.right: forgetButton.left
                                    anchors.rightMargin: 4
                                    anchors.verticalCenter: parent.verticalCenter
                                    elide: Text.ElideRight
                                    color: modelData.connected ? "#1e1e2e" : "#cdd6f4"
                                    text: modelData.name + (modelData.batteryAvailable ? " (" + Math.round(modelData.battery * 100) + "%)" : "")
                                }

                                Text {
                                    id: forgetButton
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "✕"
                                    color: forgetMouse.containsMouse ? "#f38ba8" : (modelData.connected ? "#1e1e2e" : "#6c7086")

                                    MouseArea {
                                        id: forgetMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: modelData.forget()
                                    }
                                }

                                MouseArea {
                                    id: deviceMouse
                                    anchors.left: parent.left
                                    anchors.right: forgetButton.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    hoverEnabled: true
                                    onClicked: {
                                        if (modelData.connected)
                                            modelData.disconnect();
                                        else
                                            modelData.connect();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: powerMenu

                visible: false
                color: "transparent"

                anchor.item: powerButton
                anchor.edges: Edges.Bottom | Edges.Right
                anchor.gravity: Edges.Bottom | Edges.Left
                anchor.margins.top: 4

                implicitWidth: 140
                implicitHeight: menuColumn.implicitHeight + 8

                Rectangle {
                    anchors.fill: parent
                    color: "#1e1e2e"
                    radius: 6
                    border.color: "#313244"
                    border.width: 1

                    Column {
                        id: menuColumn

                        anchors.fill: parent
                        anchors.margins: 4
                        spacing: 2

                        Repeater {
                            model: [
                                { label: "Suspend", command: ["systemctl", "suspend"] },
                                { label: "Hibernate", command: ["systemctl", "hibernate"] },
                                { label: "Shutdown", command: ["shutdown"] }
                            ]
                            delegate: powerMenuEntry
                        }
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#313244"
                        }
                        Repeater {
                            model: [
                                { label: "Reboot", command: ["reboot"] }
                            ]
                            delegate: powerMenuEntry
                        }

                        Component {
                            id: powerMenuEntry

                            Rectangle {
                                required property var modelData

                                width: menuColumn.width
                                height: 28
                                radius: 4
                                color: entryMouse.containsMouse ? "#313244" : "transparent"

                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "#cdd6f4"
                                    text: modelData.label
                                }

                                MouseArea {
                                    id: entryMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        powerMenu.visible = false;
                                        Quickshell.execDetached(modelData.command);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
