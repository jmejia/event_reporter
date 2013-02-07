module EventReporter
  class Print
    def initialize(queue)
      @attendees     = queue
      @last_name     = [10]
      @first_name    = [12]
      @email_address = [0]
      @city          = [0]
      @street        = [9]
    end

    def create_column_widths
      @attendees.each do |attendee|
        @last_name     << attendee[:last_name].to_s.size
        @first_name    << attendee[:first_name].to_s.size
        @email_address << attendee[:email_address].to_s.size
        @city          << attendee[:city].to_s.size
        @street        << attendee[:street].to_s.size
      end

      @col_01 = @last_name.sort.last
      @col_02 = @first_name.sort.last
      @col_03 = @email_address.sort.last
      @col_05 = @city.sort.last
      @col_07 = @street.sort.last # Labeled ADDRESS
    end

    def headings
      #puts @attendees.inspect
      "LAST NAME".ljust(@col_01) + " | " + "FIRST NAME".ljust(@col_02) + " | " + "EMAIL".ljust(@col_03) + " | " + "ZIPCODE".ljust(9) + " | " + "CITY".ljust(@col_05) + " | " + "STATE".ljust(7) + " | " + "ADDRESS".ljust(@col_07) + " | " + "PHONE"
    end

    def to_terminal
      puts "\n"
      create_column_widths
      puts headings
      @attendees.each do |a|
        puts "#{a[:last_name].to_s.ljust(@col_01)} | #{a[:first_name].to_s.ljust(@col_02)} | #{a[:email_address].to_s.ljust(@col_03)} | #{a[:zipcode].ljust(9)} | #{a[:city].to_s.ljust(@col_05)} | #{a[:state].ljust(7)} | #{a[:street].to_s.ljust(@col_07)} | #{a[:homephone]}"
      end
    end

  end
end
