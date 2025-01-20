const mpris = await Service.import('mpris');

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
});

export default player;