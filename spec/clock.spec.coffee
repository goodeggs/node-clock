clock = require '../src/clock'

describe 'clock', ->

  describe 'tzids', ->
    it 'includes our tzs', ->
      expect('America/Denver' in clock.tzids).toBe true
      expect(clock.tzids.length).toEqual 5

  describe '.utc', ->
    it 'parses json', ->
      expect(clock.utc('2012-03-11T09:00:00.000')).toEqual Date.parse('2012-03-11T09:00:00.000Z').valueOf()

    it 'formats a date in utc', ->
      date = new Date(clock.pacific '2012-01-01 09:00')
      expect(clock.utc(date.valueOf(), "%m/%d/%Y %H:%M")).toEqual '01/01/2012 17:00'

    it 'has a tzid', ->
      expect(clock.utc.tzid).toBeDefined()

  describe '.tz', ->
    describe 'parsing', ->

      it 'parses pacific', ->
        expect(clock.tz('2012-04-01 12:00', clock.pacific.tzid)).toEqual Date.parse('2012-04-01T19:00:00.000Z').valueOf()

      it 'parses mountain', ->
        expect(clock.tz('2012-04-01 12:00', 'America/Denver')).toEqual Date.parse('2012-04-01T18:00:00.000Z').valueOf()

      it 'parses central', ->
        expect(clock.tz('2012-04-01 12:00', 'America/Chicago')).toEqual Date.parse('2012-04-01T17:00:00.000Z').valueOf()

      it 'parses eastern', ->
        expect(clock.tz('2012-04-01 12:00', 'America/New_York')).toEqual Date.parse('2012-04-01T16:00:00.000Z').valueOf()

      it 'parses utc', ->
        expect(clock.tz('2012-04-01 12:00', 'UTC')).toEqual Date.parse('2012-04-01T12:00:00.000Z').valueOf()

      it 'throws an exception without a tzid', ->
        expect(-> clock.tz('2012-04-01 12:00')).toThrow()

    describe 'formatting', ->
      date = null

      beforeEach ->
        date = new Date(clock.pacific '2012-01-01 09:00')

      it 'formats a date in pacific timezone', ->
        expect(clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", clock.pacific.tzid)).toEqual '01/01/2012 09:00'

      it 'formats a date in mountain timezone', ->
        expect(clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'America/Denver')).toEqual '01/01/2012 10:00'

      it 'formats a date in central timezone', ->
        expect(clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'America/Chicago')).toEqual '01/01/2012 11:00'

      it 'formats a date in eastern timezone', ->
        expect(clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'America/New_York')).toEqual '01/01/2012 12:00'

      it 'formats a date in utc', ->
        expect(clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'UTC')).toEqual '01/01/2012 17:00'

      it 'throws an exception without a tzid', ->
        expect(-> clock.tz(date.valueOf(), "%m/%d/%Y %H:%M")).toThrow()

describe 'extends Number', ->
  beforeEach ->
    clock.extendNumber()
    
  it 'returns millisecond equivelants of various time units', ->
    expect(1.millisecond()).toEqual 1
    expect(1.second()).toEqual 1 * 1000
    expect(2.seconds()).toEqual 2 * 1000
    expect(1.hour()).toEqual 1 * 60 * 60 * 1000
    expect(3.days()).toEqual 3 * 24 * 60 * 60 * 1000
    expect(4.weeks()).toEqual 4 * 7 * 24 * 60 * 60 * 1000
