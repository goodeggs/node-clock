clock = require '../src/clock'
clock.extendNumber()

describe 'clock', ->

  describe '.tz', ->
    it 'parses json', ->
      expect(clock.tz('2012-03-11T09:00:00.000')).toEqual Date.parse('2012-03-11T09:00:00.000Z').valueOf()

    it 'parses pacific', ->
      expect(clock.pacific('2012-04-01 12:00')).toEqual Date.parse('2012-04-01T19:00:00.000Z').valueOf()

  describe '.daySuffix', ->
    it 'returns st for 1s', ->
      expect(clock.daySuffix('2011-10-01')).toEqual 'st'
      expect(clock.daySuffix('2011-10-11')).toEqual 'st'
      expect(clock.daySuffix('2011-10-21')).toEqual 'st'

    it 'returns nd for 2s', ->
      expect(clock.daySuffix('2011-10-02')).toEqual 'nd'
      expect(clock.daySuffix('2011-10-12')).toEqual 'nd'
      expect(clock.daySuffix('2011-10-22')).toEqual 'nd'

    it 'returns rd for 3s', ->
      expect(clock.daySuffix('2011-10-03')).toEqual 'rd'
      expect(clock.daySuffix('2011-10-13')).toEqual 'rd'
      expect(clock.daySuffix('2011-10-23')).toEqual 'rd'

    it 'returns th for everything else', ->
      expect(clock.daySuffix('2011-10-04')).toEqual 'th'
      expect(clock.daySuffix('2011-10-05')).toEqual 'th'
      expect(clock.daySuffix('2011-10-06')).toEqual 'th'
      expect(clock.daySuffix('2011-10-07')).toEqual 'th'
      expect(clock.daySuffix('2011-10-15')).toEqual 'th'
      expect(clock.daySuffix('2011-10-27')).toEqual 'th'

  describe 'extends Number', ->
    it 'returns millisecond equivelants of various time units', ->
      expect(1.millisecond).toEqual 1
      expect(1.second).toEqual 1 * 1000
      expect(2.seconds).toEqual 2 * 1000
      expect(1.hour).toEqual 1 * 60 * 60 * 1000
      expect(3.days).toEqual 3 * 24 * 60 * 60 * 1000
      expect(4.weeks).toEqual 4 * 7 * 24 * 60 * 60 * 1000

  describe 'formatting', ->

    it 'formats a date in pacific timezone', ->
      date = new Date(2012, 0, 1, 9, 0) # Jan 1 9am
      expect(clock.pacific(date.getTime(), "%m/%d/%Y")).toEqual '01/01/2012'



