const notifications = await Service.import("notifications")

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function NotificationIcon({ app_entry, app_icon, image }) {
	if (image) {
		return Widget.Box({
			css: `background-image: url("${image}");`
				+ "background-size: contain;"
				+ "background-repeat: no-repeat;"
				+ "background-position: center;",
		})
	}

	let icon = "dialog-information-symbolic"
	if (Utils.lookUpIcon(app_icon))
		icon = app_icon

	if (app_entry && Utils.lookUpIcon(app_entry))
		icon = app_entry

	return Widget.Box({
		child: Widget.Icon(icon)
	})
}

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function Notification(n) {
	const icon = Widget.Box({
		vpack: "start",
		class_name: "icon",
		child: NotificationIcon(n)
	})

	const title = Widget.Label({
		class_name: "title",
		label: n.summary,
		max_width_chars: 24,
		justification: "left",
		truncate: "end",
		halign: 1,
		xalign: 0,
		use_markup: true,
		wrap: true
	})

	const body = Widget.Label({
		class_name: "body",
		label: n.body,
		justification: "left",
		halign: 1,
		xalign: 0,
		hexpand: false,
		vexpand: true,
		use_markup: true,
		wrap: true
	})

	const actions = Widget.Box({
		class_name: "actions",
		spacing: 8,
		halign: 3,
		children: n.actions.map(({ id, label }) => Widget.Button({
			class_name: "action-button",
			on_clicked: () => {
				n.invoke(id)
				n.dismiss()
			},
			child: Widget.Label(label)
		}))
	})

	const text_box = Widget.Box({
		class_name: "text-box",
		vertical: true,
		spacing: 4,
		halign: 1,
		valign: 3,
		children: [ title ]
	})

	// only add body if there is text
	if (body.label.trim() !== "") {
		text_box.add(body);
	}

	const info_box = Widget.Box({
		class_name: "info-box",
		halign: 1,
		children: [
			icon,
			text_box
		]
	})

	const notification_box = Widget.Box({
		class_name: `notification ${n.urgency}`,
		vertical: true,
		spacing: 16,
		halign: 3,
		valign: 3,
		children: [ info_box ]
	})

	if (n.actions.length > 0) {
		notification_box.add(actions);
	}

	return Widget.EventBox(
		{
			attribute: { id: n.id },
			on_primary_click: n.dismiss,
			halign: 3,
		},
		notification_box
	)
}

export function NotificationPopups(monitor = 0) {
	const list = Widget.Box({
		class_name: "notifications",
		vertical: true,
		spacing: 16,
		children: notifications.popups.map(Notification),
	})

	function onNotified(_, /** @type {number} */ id) {
		const n = notifications.getNotification(id)
		if (n)
			list.children = [Notification(n), ...list.children]
	}

	function onDismissed(_, /** @type {number} */ id) {
		list.children.find(n => n.attribute.id === id)?.destroy()
	}

	list.hook(notifications, onNotified, "notified")
		.hook(notifications, onDismissed, "dismissed")

	return Widget.Window({
		monitor,
		name: `notifications-${monitor}`,
		class_name: "notification-popups",
		anchor: ["top"],
		child: list,
	})
}