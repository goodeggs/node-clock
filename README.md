node-clock
======

This node.js module provides a simple clock abstraction.

[![Build Status](https://travis-ci.org/goodeggs/node-clock.png)](https://travis-ci.org/goodeggs/node-clock)

# Install
    npm install node-clock

# Usage

    var clock = require('clock');
     
    > clock.tzids
    [ 'UTC', 'America/Los_Angeles', 'America/Denver', 'America/Chicago', 'America/New_York' ]

    > clock.utc('2012-03-11T09:00:00.000')
    Date.parse('2012-03-11T09:00:00.000Z').valueOf()
    
    > date = new Date(clock.pacific('2012-01-01 09:00'));
    > clock.utc(date.valueOf(), "%m/%d/%Y %H:%M")
    '01/01/2012 17:00'

    > clock.tz('2012-04-01 12:00', clock.pacific.tzid)
    Date.parse('2012-04-01T19:00:00.000Z').valueOf()
   
    > clock.tz('2012-04-01 12:00', 'America/Denver')
    Date.parse('2012-04-01T18:00:00.000Z').valueOf()
    
    > clock.tz('2012-04-01 12:00', 'America/Chicago')
    Date.parse('2012-04-01T17:00:00.000Z').valueOf()
    
    > clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", clock.pacific.tzid)
    '01/01/2012 09:00'
    
    > clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'America/Denver')
    '01/01/2012 10:00'
    
    > clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'America/Chicago')
    '01/01/2012 11:00'
    
    > clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'America/New_York')
    '01/01/2012 12:00'
    
    > clock.tz(date.valueOf(), "%m/%d/%Y %H:%M", 'UTC')
    '01/01/2012 17:00'
   