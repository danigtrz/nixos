import { App } from "astal/gtk3"
import Bar from "./windows/bar/bar"
import Applauncher from "./windows/applauncher/applauncher"
import NotificationPopups from "./windows/notifications/NotificationPopups"
import OSD from "./windows/osd/OSD"
import style from "./style.scss"

App.start({
	css: style,
	instanceName: "interface",
	main() {
		Bar(App.get_monitors().find(monitor => monitor.is_primary()));
		Applauncher()
		App.get_monitors().map(NotificationPopups)
		App.get_monitors().map(OSD)
	}
})