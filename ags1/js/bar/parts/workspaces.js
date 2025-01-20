const hyprland = await Service.import('hyprland');

const ar_zh = {
	1: '一',
	2: '二',
	3: '三',
	4: '四',
	5: '五',
	6: '六',
	7: '七',
	8: '八',
	9: '九',
	10: '十',
	11: '十一',
	12: '十二',
	13: '十三',
	14: '十四',
	15: '十五',
	16: '十六'
};

function workspaces() {
	const active_id = hyprland.active.workspace.bind('id')
	return Widget.Box({
		class_name: 'workspaces',
		spacing: 12,
		children: Array.from({ length: 16 }, (_, i) => i + 1).map(i => Widget.Button({
			onClicked: () => hyprland.messageAsync(`dispatch workspace ${i}`),
			attribute: i,
			label: ar_zh[i],
			class_name: active_id.as(j => `${j === i ? 'focused' : ''}`)
		})),
		setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
			btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute);
		}))
	})
};

export default workspaces;