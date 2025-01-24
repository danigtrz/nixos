import { App } from "astal/gtk3"
import Bar from "./windows/bar/bar"

App.start({
	main() {
		Bar()
	}
})
