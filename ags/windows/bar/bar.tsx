// import { App } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Battery from "gi://AstalBattery"
import Mpris from "gi://AstalMpris"
import Wp from "gi://AstalWp"
import Network from "gi://AstalNetwork"
import Tray from "gi://AstalTray"

function Workspaces() {
	const hypr = Hyprland.get_default()

	return <box className="Workspaces">
		{bind(hypr, "workspaces").as(wss => wss
			// .filter(ws => !(ws.id >= -99 && ws.id <= -2))
			.sort((a, b) => a.id - b.id)
			.map(ws => (
				<button
					className={bind(hypr, "focusedWorkspace").as(fw =>
						ws === fw ? "focused" : "")}
					onClicked={() => ws.focus()}>
					{ws.id}
				</button>
			))
		)}
	</box>
}

function BatteryIndicator() {
	const bat = Battery.get_default()

	return <box className="Battery" visible={bind(bat, "isPresent")}>
		<icon icon={bind(bat, "batteryIconName")} />
		<label label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)} %`)} />
	</box>
}

function Time({ format = "%H:%M - %A %e" }) {
	const time = Variable<string>("").poll(1000, () =>
		GLib.DateTime.new_now_local().format(format)!)

	return <label
		className="Time"
		onDestroy={() => time.drop()}
		label={time()}
	/>
}

export default function Bar(monitor: Gdk.Monitor) {
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

	return <window
		className="Bar"
		gdkmonitor={monitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | LEFT | RIGHT}>
		<centerbox>
			<box hexpand halign={Gtk.Align.START}>
				<Workspaces />
			</box>
			<box>
				<Time />
			</box>
			<box hexpand halign={Gtk.Align.END} >
				<BatteryIndicator />
			</box>
		</centerbox>
	</window>
}