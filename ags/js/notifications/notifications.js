export default async function init() {
	const bat = await Service.import("battery")
	bat.connect("notify::percent", ({ percent, charging }) => {
		const low = 30

		if (percent !== low || percent !== low / 2 || !charging)
			return
		
		Utils.notify({
			summary: "Low Battery",
			body: `Battery at ${percent}%. Consider not running out of battery.`,
			iconName: "battery-low-symbolic",
			urgency: "critical"
		})
	})
}