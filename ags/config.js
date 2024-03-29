// import Gtk from 'gi://Gtk?version=3.0';

// Gtk.IconTheme.get_default().append_search_path('./assets');

import bar from './js/bar/bar.js';
import { applauncher } from './js/applauncher/applauncher.js';
import { NotificationPopups } from "./js/notifications/notification_popups.js";

Utils.timeout(100, () => Utils.notify({
	summary: "Notification Popup Example",
	iconName: "info-symbolic",
	body: "Lorem ipsum dolor sit amet, qui minim labore adipisicing "
		+ "minim sint cillum sint consectetur cupidatat.",
	actions: {
		"Cool": () => print("pressed Cool")
	}
}))

Utils.timeout(100, () => Utils.notify({
	summary: "Battery Low",
	iconName: "battery-low-symbolic",
	body: "Consider not running out of battery."
}))

export default {
	style: './style.css',
	windows: [
		bar(),
		NotificationPopups(),
		applauncher
	]
};