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

// function Media() {
// 	const mpris = Mpris.get_default()

// 	return <box className="Media" visible={bind(mpris, "players").as(ps => !!ps[0])}>
// 		{bind(mpris, "players").as(ps => ps[0] ? (
// 			<box>
// 				<box
// 					className="Cover"
// 					valign={Gtk.Align.CENTER}
// 					css={bind(ps[0], "coverArt").as(cover =>
// 						`background-image: url('${cover}');`
// 					)}
// 				/>
// 				<label
// 					label={bind(ps[0], "metadata").as(() =>
// 						`${ps[0].title} - ${ps[0].artist}`
// 					)}
// 				/>
// 			</box>
// 		) : null)}
// 	</box>
// }

function Media() {
	const mpris = Mpris.get_default();

	return (
		<box className="Media" visible={bind(mpris, "players").as(ps => !!ps[0])}>
			{bind(mpris, "players").as(ps => ps[0] && (
				<box>
					{/* <box
						className="Cover"
						valign={Gtk.Align.CENTER}
						css={bind(ps[0], "coverArt").as(cover =>
							`background-image: url('${cover}');`
						)}
					/> */}
					<label
						label={bind(ps[0], "metadata").as(() =>
							`${ps[0].title} - ${ps[0].artist}`
						)}
					/>
				</box>
			))}
		</box>
	);
}

// function SysTray() {
// 	const tray = Tray.get_default()

// 	return <box className="SysTray">
// 		{bind(tray, "items").as(items => items.map(item => (
// 			<menubutton
// 				tooltipMarkup={bind(item, "tooltipMarkup")}
// 				usePopover={false}
// 				actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
// 				menuModel={bind(item, "menuModel")}>
// 				<icon gicon={bind(item, "gicon")} />
// 			</menubutton>
// 		)))}
// 	</box>
// }

// function AudioSlider() {
// 	const speaker = Wp.get_default()?.audio.defaultSpeaker!

// 	return <box className="AudioSlider" css="min-width: 140px">
// 		<icon icon={bind(speaker, "volumeIcon")} />
// 		<slider
// 			hexpand
// 			onDragged={({ value }) => speaker.volume = value}
// 			value={bind(speaker, "volume")}
// 		/>
// 	</box>
// }

function BatteryIndicator() {
	const bat = Battery.get_default()

	return <box className="Battery" visible={bind(bat, "isPresent")}>
		<icon icon={bind(bat, "batteryIconName")} />
		<label label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)} %`)} />
	</box>
}

function Date({ format = "%A, %B %e" }) {
	const time = Variable<string>("").poll(1000, () =>
		GLib.DateTime.new_now_local().format(format)!)

	return <label
		className="Date"
		onDestroy={() => time.drop()}
		label={time()}
	/>
}

function Time({ format = "%H:%M" }) {
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
		name="bar"
		className="Bar"
		gdkmonitor={monitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | LEFT | RIGHT}>
		<centerbox>
			<box hexpand halign={Gtk.Align.START}>
				<Workspaces />
				<Media />
			</box>
			<box>
			</box>
			<box hexpand halign={Gtk.Align.END} >
				{/* <SysTray /> */}
				{/* <AudioSlider /> */}
				<BatteryIndicator />
				<Date />
				<Time />
			</box>
		</centerbox>
	</window>
}