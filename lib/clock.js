var clock, defaultTimezone, tz;

tz = require('timezone').tz;

tz.timezones(require('timezone/timezones/northamerica'));

defaultTimezone = 'America/Los_Angeles';

module.exports = clock = {
  now: function() {
    return Date.now();
  },
  pacific: tz.specialize(defaultTimezone),
  tz: tz,
  dayInWeek: function(time, day, timezone) {
    var dayIndex;
    if (timezone == null) timezone = defaultTimezone;
    dayIndex = tz.locales().en_US.day.full.indexOf(day);
    if (tz(time, '%w', timezone) === '0') {
      return tz(time, "+" + dayIndex + " days", timezone);
    } else {
      return tz(time, '-1 sunday', "+" + dayIndex + " days", timezone);
    }
  },
  daySuffix: function(time, timezone) {
    if (timezone == null) timezone = defaultTimezone;
    switch (tz(time, '%d')[1]) {
      case '1':
        return 'st';
      case '2':
        return 'nd';
      case '3':
        return 'rd';
      default:
        return 'th';
    }
  }
};
