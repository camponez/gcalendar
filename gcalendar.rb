# Google calendar ics formater
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

  def new_event(d, event_name, summary)
    event = "BEGIN:VEVENT\n"
    event += "UID:#{format_date(d)}@#{event_name}\n"
    event += "SUMMARY: #{summary}DESCRIPTION:-\n"
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
