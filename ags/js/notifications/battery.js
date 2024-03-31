export default async function init() {
	const bat = await Service.import("battery")
	bat.connect("notify::percent", ({ percent, charging }) => {
		if (percent !== 15 || charging)
			return

		Utils.notify({
			summary: "Low Battery",
			body: `Battery is at ${percent}%. Consider doing something about it.`,
			iconName: "battery-low-symbolic",
			urgency: "critical"
		})
	})
}