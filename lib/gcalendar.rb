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

# Gcalendar
class GCalendar
  def initialize(_prodid, _timezone)
    @proid = _prodid
    @timezone = _timezone
    @events = []
  end

  def format_date(d)
    d.strftime('%Y%m%dT%H%M%S')
  end

  def new_event(_date, event_name, _summary, _description, _duration = 2)
    @events.push(
      event_name: event_name,
      date: _date,
      summary: _summary,
      description: _description,
      duration: _duration
    )
  end

  def head_events
    @ics = "BEGIN:VCALENDAR\n"
    @ics += "VERSION:2.0\n"
    @ics += "CALSCALE:GREGORIAN\n"
    @ics += "PRODID:-//#{@proid}//PT\n"
    @ics += "X-WR-TIMEZONE:#{@timezone}\n"
  end

  def merge_events
    @events.each do |_event|
      _d = format_date(_event[:date])
      @ics += "BEGIN:VEVENT\n"
      @ics += "UID:#{_d}@#{_event[:event_name]}\n"
      @ics += "SUMMARY: #{_event[:summary]}\n"
      @ics += "DESCRIPTION:#{_event[:description]}\n"
      @ics += "DTSTAMP:#{_d}\nDTSTART:#{_d}\n"
      _d = format_date(_event[:date] + Rational(60 * _event[:duration], 1440))
      @ics += "DTEND:#{_d}\nEND:VEVENT\n"
    end
  end

  def show_ics
    head_events
    merge_events
    @ics += 'END:VCALENDAR'
  end
end
