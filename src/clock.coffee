tz = require('timezone')

defaultTimezone = 'America/Los_Angeles'

module.exports = clock =
  # Per timezone's convention, an absolute time (without timezone) is specified as milliseconds since the epoch.
  now: ->
    Date.now()

  pacific: tz require('timezone/America'), defaultTimezone

  tz: tz

  daySuffix: (time, timezone = defaultTimezone) ->
    switch tz(time, '%d')[1]
      when '1'
        'st'
      when '2'
        'nd'
      when '3'
        'rd'
      else 'th'

  # Am I being bad here?
  extendNumber: ->
    if not Number::.milliseconds
      for [unit, multiplier, subunit] in [
        ['millisecond', 1]
        ['second', 1000, 'milliseconds']
        ['minute', 60, 'seconds']
        ['hour', 60, 'minutes']
        ['day', 24, 'hours']
        ['week', 7, 'days']
      ]
        do (unit, multiplier, subunit) ->
          subunitCount = subunit? and multiplier[subunit] or multiplier
          for prop in [unit, unit + 's']
            do (prop) ->
              Object.defineProperty Number::, prop,
                enumerable: false
                get: ->
                  @ * subunitCount

