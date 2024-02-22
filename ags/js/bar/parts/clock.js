import datetime from '../../../lib/datetime.js';

const time_format = Variable('%H:%M');
const time = Utils.derive([datetime, time_format], (c, f) => c.format(f));

const clock = () => Widget.Label({
	class_name: 'clock',
	label: time.bind()
});

export default clock;