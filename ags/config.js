import Gtk from 'gi://Gtk?version=3.0';

Gtk.IconTheme.get_default().append_search_path('./assets');

import bar from './js/bar/bar.js';

export default {
	style: './style.css',
	windows: [
		bar()
	]
};