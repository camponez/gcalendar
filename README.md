[![Build Status](https://travis-ci.org/camponez/gcalendar.svg?branch=master)](https://travis-ci.org/camponez/gcalendar)
[![Test Coverage](https://api.codeclimate.com/v1/badges/734e4d9ccd774ac5be08/test_coverage)]
[![](https://github.com/camponez/gcalendar/workflows/Ruby/badge.svg)]

This will help to generate a ics file to be imported into Google Calendar.

## Code example

```ruby
require 'date'
require './lib/gcalendar'

my_events = [
  {
    'name':'My flight',
    'date':'2017-09-12 10:30',
    'summary': 'Flight to Berlin',
    'description': 'Long flight it will be',
    'duration': 2
  },
  {
    'name':'My second event',
    'date':'2017-09-13 14:30',
    'summary': 'Doctor appoitment',
    'description': 'Dr. James needs the exams',
    'duration': 1
  }
]

g = GCalendar.new('MY_CALENDAR_ID', 'Europe/Berlin')

for e in my_events
  g.new_event(DateTime.parse(e[:date]), e[:name], e[:summary],
              e[:description], e[:duration])
end

puts(g.show_ics())

```

### Output
```
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
PRODID:-//MY_CALENDAR_ID//PT
X-WR-TIMEZONE:Europe/Berlin
BEGIN:VEVENT
UID:20170912T103000@My flight
SUMMARY: Flight to Berlin
DESCRIPTION:Long flight it will be
DTSTAMP:20170912T103000
DTSTART:20170912T103000
DTEND:20170912T123000
END:VEVENT
BEGIN:VEVENT
UID:20170913T143000@My second event
SUMMARY: Doctor appoitment
DESCRIPTION:Dr. James needs the exams
DTSTAMP:20170913T143000
DTSTART:20170913T143000
DTEND:20170913T153000
END:VEVENT
END:VCALENDAR
```
