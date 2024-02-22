import launcher from './parts/launcher.js';
import workspaces from './parts/workspaces.js';
import player from './parts/player.js';
import volume from './parts/volume.js';
import battery from './parts/battery.js';
import calendar from './parts/calendar.js';
import clock from './parts/clock.js';

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
});

const right = () => Widget.Box({
	hpack: 'end',
	children: [
		volume(),
		battery(),
		calendar(),
		clock()
	]
});

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
});

export default bar;