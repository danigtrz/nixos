const { query } = await Service.import('applications');

const WINDOW_NAME = 'applauncher';

const AppItem = app => Widget.Button({
	on_clicked: () => {
		App.closeWindow(WINDOW_NAME);
		app.launch();
	},
	attribute: { app },
	child: Widget.Box({
		children: [
			Widget.Icon({
				icon: app.icon_name || '',
				size: 42
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

const Applauncher = ({ width = 500, height = 500, spacing = 12 }) => {
	// list of application buttons
	let applications = query('').map(AppItem);

	// container holding buttons
	const list = Widget.Box({
		vertical: true,
		children: applications,
		spacing
	});

	// repopulate box, so most used items are at the top
	function repopulate() {
		applications = query('').map(AppItem);
		list.children = applications;
	};

	// search entry
	const entry = Widget.Entry({
		hexpand: true,
		css: `margin-bottom: ${spacing}px;`,

		// to launch the first item on Enter
		on_accept: () => {
			if (applications[0]) {
				App.toggleWindow(WINDOW_NAME);
				applications[0].attribute.app.launch();
			}
		},

		// filter list
		on_change: ({ text }) => applications.forEach(item => {
			item.visible = item.attribute.app.match(text ?? '');
		})
	});

	return Widget.Box({
		vertical: true,
		css: `margin: ${spacing * 2}px;`,
		children: [
			entry,

			// wrap list in scrollable
			Widget.Scrollable({
				hscroll: 'never',
				css: `
					min-width: ${width}px;
					min-height: ${height}px;
				`,
				child: list,
			})
		],
		setup: self => self.hook(App, (_, windowName, visible) => {
			if (windowName !== WINDOW_NAME)
				return;

			// when applauncher appears
			if (visible) {
				repopulate();
				entry.text = '';
				entry.grab_focus();
			}
		})
	});
};

export const applauncher = Widget.Window({
	name: WINDOW_NAME,
	setup: self => self.keybind('Escape', () => {
		App.closeWindow(WINDOW_NAME)
	}),
	visible: false,
	keymode: 'exclusive',
	child: Applauncher({
		width: 500,
		height: 500,
		spacing: 12
	})
});