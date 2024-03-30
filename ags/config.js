// import Gtk from 'gi://Gtk?version=3.0';

// Gtk.IconTheme.get_default().append_search_path('./assets');

import bar from './js/bar/bar.js';
import { applauncher } from './js/applauncher/applauncher.js';
import { NotificationPopups } from "./js/notifications/notification_popups.js";

export default {
	style: './style.css',
	windows: [
		bar(),
		NotificationPopups(),
		applauncher
	]
};