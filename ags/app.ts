import { App } from "astal/gtk3"
import Bar from "./windows/bar/bar"
import Applauncher from "./windows/applauncher/applauncher"
import NotificationPopups from "./notifications/NotificationPopups"
import style from "./style.scss"

App.start({
	css: style,
	instanceName: "interface",
	main() {
		Bar()
		Applauncher()
		NotificationPopups()
	}
})