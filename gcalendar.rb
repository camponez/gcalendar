# Google calendar ics formater
#
# (c) Copyright 2017 Eduardo Elias <camponez@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class GCalendar
  def initialize(prodid, timezone)
    @ics = "BEGIN:VCALENDAR\n"
    @ics += "VERSION:2.0\n"
    @ics += "CALSCALE:GREGORIAN\n"
    @ics += "PRODID:-//#{prodid}//PT\n"
    @ics += "X-WR-TIMEZONE:#{timezone}\n"

    @events = []
  end

  def format_date(d)
    d.strftime('%Y%m%dT%H%M%S')
  end

  def new_event(d, event_name, summary, description)
    event = "BEGIN:VEVENT\n"
    event += "UID:#{format_date(d)}@#{event_name}\n"
    event += "SUMMARY: #{summary}\n"
    event += "DESCRIPTION:#{description}\n"
    event += "DTSTAMP:#{format_date(d)}\nDTSTART:#{format_date(d)}\n"
    d += Rational(120, 1440)
    event += "DTEND:#{format_date(d)}\nEND:VEVENT\n"

    @events.push(event)
  end

  def show_events
    @events.each do |event|
      @ics += event
    end
  end

  def show_ics
    show_events
    @ics += 'END:VCALENDAR'
  end
end
