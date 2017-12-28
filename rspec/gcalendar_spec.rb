# spec/gcalendar_spec.rb
require 'date'
require 'gcalendar'

describe GCalendar do
  describe '#new_event' do
    before(:context) do
      @calendar = GCalendar.new('PRODID', 'GMT')
    end

    it 'creates new event' do
      @calendar.new_event(DateTime.parse('2017-10-01 10:00'), 'event_name',
                          'summary for the event', 'description for the event',
                          1)

      expect(@calendar.show_ics).to eql("BEGIN:VCALENDAR\nVERSION:2.0\nCALSCALE:GREGORIAN\nPRODID:-//PRODID//PT\nX-WR-TIMEZONE:GMT\nBEGIN:VEVENT\nUID:20171001T100000@event_name\nSUMMARY: summary for the event\nDESCRIPTION:description for the event\nDTSTAMP:20171001T100000\nDTSTART:20171001T100000\nDTEND:20171001T110000\nEND:VEVENT\nEND:VCALENDAR")
    end

    it 'creates a second event' do
      @calendar.new_event(DateTime.parse('2017-10-02 12:00'), 'event_name2',
                          'summary second event', 'description 2nd event', 3)

      expect(@calendar.show_ics).to eql("BEGIN:VCALENDAR\nVERSION:2.0\nCALSCALE:GREGORIAN\nPRODID:-//PRODID//PT\nX-WR-TIMEZONE:GMT\nBEGIN:VEVENT\nUID:20171001T100000@event_name\nSUMMARY: summary for the event\nDESCRIPTION:description for the event\nDTSTAMP:20171001T100000\nDTSTART:20171001T100000\nDTEND:20171001T110000\nEND:VEVENT\nBEGIN:VEVENT\nUID:20171002T120000@event_name2\nSUMMARY: summary second event\nDESCRIPTION:description 2nd event\nDTSTAMP:20171002T120000\nDTSTART:20171002T120000\nDTEND:20171002T150000\nEND:VEVENT\nEND:VCALENDAR")
    end
  end
end
