import datetime from '../../../lib/datetime.js';

const date_format = Variable('%Y年%m月%d日');
const date = Utils.derive([datetime, date_format], (c, f) => c.format(f));

const calendar = () => Widget.Label({
	class_name: 'calendar',
	label: date.bind()
});

export default calendar;
