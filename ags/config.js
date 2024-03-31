// import Gtk from 'gi://Gtk?version=3.0';

// Gtk.IconTheme.get_default().append_search_path('./assets');

import bar from './js/bar/bar.js';
import { applauncher } from './js/applauncher/applauncher.js';
import { NotificationPopups } from './js/notifications/notification_popups.js';

import low_battery from './js/notifications/battery.js';
low_battery();

Utils.timeout(100, () => Utils.notify({
	summary: "Welcome to the Hideout.",
	iconName: "face-smile-big-symbolic"
}));

Utils.timeout(200, () => Utils.notify({
	summary: "Welcome to the Hideout.",
	iconName: "face-smile-big-symbolic",
	urgency: "critical",
	actions: {
		"Go": () => print(),
		"Don't go": () => print(),
	}
}));

Utils.timeout(300, () => Utils.notify({
	summary: "You have a new message.",
	body: "You have a a lot of messages. You should check them out. You should really look at them. You should look at them now. Why aren't you looking at them?",
	iconName: "face-smile-big-symbolic",
	urgency: "normal"
}));

Utils.timeout(400, () => Utils.notify({
	summary: "Click here. Now.",
	body: "Isn't it about time you look at your messages? Click here to look at them. Click now. Why aren't you clicking?",
	actions: {
		"Check": () => print(),
		"Check 'em": () => print(),
		"Check messages immediately": () => print(),
		"Check...": () => print()
	},
	iconName: "face-smile-big-symbolic",
	urgency: "normal"
}));

App.config({
    style: './style.css',
    windows: [
        bar(),
		NotificationPopups(),
		applauncher
    ]
});