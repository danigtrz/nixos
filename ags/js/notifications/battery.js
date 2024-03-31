export default async function init() {
	const bat = await Service.import("battery")
	bat.connect("notify::percent", ({ percent, charging }) => {
		if (percent !== 68 || charging)
			return

		Utils.notify({
			summary: "Low Battery",
			body: `Battery at ${percent}%. Consider not running out of battery.`,
			iconName: "battery-low-symbolic",
			urgency: "critical"
		})
	})
}