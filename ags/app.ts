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
		App.get_monitors().map(Bar)
		Applauncher()
		App.get_monitors().map(NotificationPopups)
		App.get_monitors().map(OSD)
	}
})