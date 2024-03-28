import Gtk from 'gi://Gtk?version=3.0';

const { query } = await Service.import('applications');

const WINDOW_NAME = 'applauncher';

const AppItem = app => Widget.Button({
	on_clicked: () => {
		App.closeWindow(WINDOW_NAME);
		app.launch();
	},
	attribute: { app },
	child: Widget.Box({
		class_name: 'app-box',
		children: [
			Widget.Icon({
				icon: app.icon_name || '',
				size: 32
			}),
			Widget.Label({
				class_name: 'title',
				label: app.name,
				xalign: 0,
				vpack: 'center',
				truncate: 'end'
			})
		]
	})
});

const Applauncher = () => {
	// list of application buttons
	let applications = query('').map(AppItem);

	// container holding buttons
	const list = Widget.Box({
		class_name: 'inner-box',
		vertical: true,
		children: applications
	});

	// repopulate box, so most used items are at the top
	function repopulate() {
		applications = query('').map(AppItem);
		list.children = applications;
	};

	// search entry
	const entry = Widget.Entry({
		hexpand: true,
		placeholder_text: 'find anything you want',

		// to launch the first item on Enter
		on_accept: () => {
			// make sure we only consider visible (searched for) applications
			const results = applications.filter((item) => item.visible);
			if (results[0]) {
				App.toggleWindow(WINDOW_NAME)
				results[0].attribute.app.launch()
			}
		},

		// filter list
		on_change: ({ text }) => applications.forEach(item => {
			item.visible = item.attribute.app.match(text ?? '');
		})
	});
	// entry.set_icon_from_icon_name(Gtk.EntryIconPosition.PRIMARY, '\udb80\udf49');

	// const entry = Widget.Box({
	// 	class_name: 'entry-box',
	// 	children: [
	// 		Widget.Label({
	// 			class_name: 'search-icon',
	// 			label: '\udb80\udf49',
	// 			xalign: 0,
	// 			vpack: 'center'
	// 		}),
	// 		Widget.Entry({
	// 			hexpand: true,
		
	// 			// to launch the first item on Enter
	// 			on_accept: () => {
	// 				if (applications[0]) {
	// 					App.toggleWindow(WINDOW_NAME);
	// 					applications[0].attribute.app.launch();
	// 				}
	// 			},
		
	// 			// filter list
	// 			on_change: ({ text }) => applications.forEach(item => {
	// 				item.visible = item.attribute.app.match(text ?? '');
	// 			})
	// 		})
	// 	]
	// });

	return Widget.Box({
		class_name: 'outer-box',
		vertical: true,
		children: [
			entry,

			// wrap list in scrollable
			Widget.Scrollable({
				vscroll: 'external',
				hscroll: 'never',
				child: list,
			})
		],
		setup: self => self.hook(App, (_, windowName, visible) => {
			if (windowName !== WINDOW_NAME)
				return;

			// when applauncher appears
			if (visible) {
				repopulate();
				entry.set_text('');
				entry.grab_focus();
			}
		})
	});
};

export const applauncher = Widget.Window({
	name: WINDOW_NAME,
	setup: self => self.keybind("Escape", () => {
		App.closeWindow(WINDOW_NAME)
	}),
	visible: false,
	keymode: 'exclusive',
	child: Applauncher()
});