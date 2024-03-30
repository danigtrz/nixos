export default async function init() {
	const bat = await Service.import("battery")
	bat.connect("notify::percent", ({ percent, charging }) => {
		if (percent === 85 && !charging) {
			Utils.notify({
				summary: "Low Battery",
				body: `Battery at ${percent}%. Consider not running out of battery.`,
				iconName: "battery-low-symbolic",
				urgency: "critical"
			})
		}
	})
}