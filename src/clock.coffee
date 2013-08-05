_ = require 'underscore'

zoneData = [
  require 'timezone/America/Los_Angeles'
  require 'timezone/America/Denver'
  require 'timezone/America/Chicago'
  require 'timezone/America/New_York'
]

tzids = _(zoneData).chain()
  .map (data) ->
    _(data.zones).keys()
  .flatten()
  .value()
  .concat(['UTC'])

validTzids = _(tzids).groupBy((tzid) -> tzid)

tz = require('timezone')(_(zoneData).values())

tzWithId = (tzid) ->
  timezone = tz(tzid)
  timezone.tzid = tzid
  timezone

module.exports = clock =
  tzids: tzids

  # Per timezone's convention, an absolute time (without timezone) is specified as milliseconds since the epoch.
  now: ->
    Date.now()

  utc: tz

  tz: (args...) ->
    throw new Error('You must specify a valid tzid') if not validTzids[args[args.length - 1]]?
    tz(args...)

  # create convenience methods
  pacific: tzWithId('America/Los_Angeles')
  mountain: tzWithId('America/Denver')
  central: tzWithId('America/Chicago')
  eastern: tzWithId('America/New_York')

  # Am I being bad here?
  extendNumber: ->
    if not Number::milliseconds?
      for [unit, multiplier, subunit] in [
        ['millisecond', 1]
        ['second', 1000, 'milliseconds']
        ['minute', 60, 'seconds']
        ['hour', 60, 'minutes']
        ['day', 24, 'hours']
        ['week', 7, 'days']
      ]
        do (unit, multiplier, subunit) ->
          subunitCount = if subunit? then multiplier[subunit]() else multiplier
          for prop in [unit, unit + 's']
            do (prop) ->
              Number::[prop] = ->
                @ * subunitCount
      Number::ago = ->
        clock.now() - @