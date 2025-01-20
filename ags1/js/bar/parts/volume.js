const audio = await Service.import('audio');

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
});

export default volume;