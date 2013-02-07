require 'csv'

module EventReporter
  class Write

    def initialize(attendees, filename)
      @attendees = attendees
      @filename = filename
    end

    def csv
      CSV.open(@filename,'w') do |row|
        row << %w"id regdate first_name last_name email_address homephone street city state zipcode"
        @attendees.each do |attendee|
          row << [attendee[:id], attendee[:regdate].to_s, attendee[:first_name].to_s.capitalize, attendee[:last_name].to_s.capitalize, attendee[:email_address].to_s, attendee[:homephone].to_s, attendee[:street].to_s, attendee[:city].to_s, attendee[:state].to_s, attendee[:zipcode].to_s]
        end
      end
      puts "Saved #{@filename}"
    end
  end
end
