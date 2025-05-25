import { App } from "astal/gtk3"
import Bar from "./windows/bar/bar"
import Applauncher from "./windows/applauncher/applauncher"
// import NotificationPopups from "./notifications/NotificationPopups"
import OSD from "./osd/OSD"
import style from "./style.scss"

App.start({
	css: style,
	instanceName: "interface",
	main() {
		Bar()
		Applauncher()
		// App.get_monitors().map(NotificationPopups)
		App.get_monitors().map(OSD)
	}
})