// Generated by CoffeeScript 1.3.3
var clock, defaultTimezone, tz;

tz = require('timezone');

defaultTimezone = 'America/Los_Angeles';

module.exports = clock = {
  now: function() {
    return Date.now();
  },
  pacific: tz(require('timezone/zones/America/Los_Angeles'), defaultTimezone),
  tz: tz,
  daySuffix: function(time, timezone) {
    if (timezone == null) {
      timezone = defaultTimezone;
    }
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
  },
  extendNumber: function() {
    var multiplier, subunit, unit, _i, _len, _ref, _ref1, _results;
    if (!Number.prototype.milliseconds) {
      _ref = [['millisecond', 1], ['second', 1000, 'milliseconds'], ['minute', 60, 'seconds'], ['hour', 60, 'minutes'], ['day', 24, 'hours'], ['week', 7, 'days']];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        _ref1 = _ref[_i], unit = _ref1[0], multiplier = _ref1[1], subunit = _ref1[2];
        _results.push((function(unit, multiplier, subunit) {
          var prop, subunitCount, _j, _len1, _ref2, _results1;
          subunitCount = (subunit != null) && multiplier[subunit] || multiplier;
          _ref2 = [unit, unit + 's'];
          _results1 = [];
          for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
            prop = _ref2[_j];
            _results1.push((function(prop) {
              return Object.defineProperty(Number.prototype, prop, {
                enumerable: false,
                get: function() {
                  return this * subunitCount;
                }
              });
            })(prop));
          }
          return _results1;
        })(unit, multiplier, subunit));
      }
      return _results;
    }
  }
};