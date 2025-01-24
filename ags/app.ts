import { App } from "astal/gtk3"
import Bar from "./windows/bar/bar"
import Applauncher from "./windows/applauncher/applauncher"

App.start({
	main() {
		Bar()
		Applauncher()
	}
})
