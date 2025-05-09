import { App } from "astal/gtk3"
import Bar from "./windows/bar/bar"
import Applauncher from "./windows/applauncher/applauncher"
import style from "./style.scss"

App.start({
	css: style,
	instanceName: "interface",
	main() {
		Bar()
		Applauncher()
	}
})

/*
import { App } from "astal/gtk4";
import windows from "./windows";

App.start({
	main() {
		windows.map((win)) => App.get_monitors().map(win)
	}
});
*/
