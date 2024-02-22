const battery_service = await Service.import('battery');

const battery = () => Widget.Box({
	class_name: 'battery',
	spacing: 8,
	children: [
		Widget.Icon('battery'),
		Widget.ProgressBar({
			vpack: 'center',
			fraction: battery_service.bind('percent').as(p => p > 0 ? p / 100 : 0)
		})
	]
});

export default battery;