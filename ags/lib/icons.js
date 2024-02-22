import Gtk from 'gi://Gtk?version=3.0';

Gtk.IconTheme.get_default().append_search_path('../assets');

export default {
    icons: '../assets'
}