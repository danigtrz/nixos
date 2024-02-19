import GLib from "gi://GLib"

const hyprland = await Service.import('hyprland');
const mpris = await Service.import('mpris');
const audio = await Service.import('audio');
const battery = await Service.import('battery');
// const notifications = await Service.import('notifications');

const datetime = Variable(GLib.DateTime.new_now_local(), {
	poll: [1000, () => GLib.DateTime.new_now_local()]
})

const date_format = Variable('%A, %B %e');
const date = Utils.derive([datetime, date_format], (c, f) => c.format(f))

const time_format = Variable('%H:%M');
const time = Utils.derive([datetime, time_format], (c, f) => c.format(f))

const calendar = () => Widget.Label({
	class_name: 'calendar',
	label: date.bind()
})

const clock = () => Widget.Label({
	class_name: 'clock',
	label: time.bind()
})

const volume = () => Widget.Box({
	class_name: 'volume',
	children: [
		Widget.Icon('audio-volume-high'),
		Widget.ProgressBar({
			vpack: 'center',
			fraction: audio.speaker.volume
		})
	]
})

const battery_label = () => Widget.Box({
	class_name: 'battery',
	children: [
		Widget.Icon('battery'),
		Widget.ProgressBar({
			vpack: 'center',
			fraction: battery.bind('percent').as(p => p > 0 ? p / 100 : 0)
		})
	]
})

function workspace_list() {
	const workspaces = hyprland.bind('workspaces')
	const active_id = hyprland.active.workspace.bind('id')
	return Widget.Box({
		class_name: 'workspaces',
		children: workspaces.as(ws => ws.map(({ id }) => Widget.Button({
			on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
			child: Widget.Label(`${id}`),
			class_name: active_id.as(i => `${i === id ? 'focused' : ''}`)
		})))
	})
}

const media = () => Widget.Button({
	class_name: 'media',
	on_primary_click: () => mpris.getPlayer('')?.playPause(),
	child: Widget.Label('-').hook(mpris, self => {
		if (mpris.players[0]) {
			const { track_artists, track_title } = mpris.players[0]
			self.label = `${track_artists.join(', ')} - ${track_title}`
		} else {
			self.label = ''
		}
	}, 'player-changed')
})

const player = () => Widget.Box({
	class_name: 'player',
	children: [
		media()
	]
})

const left = () => Widget.Box({
	children: [
		workspace_list()
	]
})

const center = () => Widget.Box({
	children: [
		player()
	]
})

const right = () => Widget.Box({
	hpack: 'end',
	children: [
		volume(),
		battery_label(),
		calendar(),
		clock()
	]
})

const bar = (monitor = 0) => Widget.Window({
	name: `bar-${monitor}`,
	class_name: 'bar',
	monitor: monitor,
	anchor: ['top', 'left', 'right'],
	margins: [0, 6],
	exclusivity: 'exclusive',
	child: Widget.CenterBox({
		start_widget: left(),
		center_widget: center(),
		end_widget: right()
	})
})

export default {
	style: './style.css',
	windows: [
		bar()
	]
}