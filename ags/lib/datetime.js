import GLib from "gi://GLib";

const datetime = Variable(GLib.DateTime.new_now_local(), {
	poll: [1000, () => GLib.DateTime.new_now_local()]
});

export default datetime;