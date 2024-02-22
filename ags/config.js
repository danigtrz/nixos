import GLib from "gi://GLib"

const hyprland = await Service.import('hyprland');
const mpris = await Service.import('mpris');
const audio = await Service.import('audio');
// const notifications = await Service.import('notifications');

import battery from './js/battery.js';

const datetime = Variable(GLib.DateTime.new_now_local(), {
	poll: [1000, () => GLib.DateTime.new_now_local()]
})

const date_format = Variable('%Y年%m月%d日');
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
	spacing: 8,
	children: [
		Widget.Icon().hook(audio.speaker, self => {
			const icon = audio.speaker.volume > 1 ? 'overamplified' : 'high';
			self.icon = audio.speaker.stream.isMuted ? 'audio-volume-muted' : `audio-volume-${icon}`;
		}),
		Widget.ProgressBar({
			vpack: 'center',
			fraction: audio.speaker.bind('volume')
		})
	]
})

const launcher = () => Widget.Box({
	class_name: 'launcher',
	children: [
		Widget.Button({
			child: Widget.Icon('audio-volume-high'),
			// on_primary_click: () => 
		})
	]
})

const ar_zh = {
	1: '一',
	2: '二',
	3: '三',
	4: '四',
	5: '五',
	6: '六',
	7: '七',
	8: '八',
	9: '九',
	10: '十',
	11: '十一',
	12: '十二',
}

function workspaces() {
	const active_id = hyprland.active.workspace.bind('id')
	return Widget.Box({
		class_name: 'workspaces',
		spacing: 12,
		children: Array.from({ length: 12 }, (_, i) => i + 1).map(i => Widget.Button({
			onClicked: () => hyprland.messageAsync(`dispatch workspace ${i}`),
			attribute: i,
			label: ar_zh[i],
			class_name: active_id.as(j => `${j === i ? 'focused' : ''}`)
		})),
		setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
			btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute);
		}))
	})
}

const player = () => Widget.Box({
	class_name: 'player',
	children: [
		Widget.Button({
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
	],
	setup: self => self.hook(mpris, () => {
		self.visible = mpris.players[0] ? true : false;
	}, 'changed')
})

const left = () => Widget.Box({
	children: [
		launcher(),
		workspaces()
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
		battery(),
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
	layer: 'bottom',
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