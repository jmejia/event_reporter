require 'csv'
require_relative 'attendee'

module EventReporter
  class AttendeeList
    attr_reader :attendees

    def initialize(file)
      @original_attendees = CSV.open(file, :headers => true, :header_converters => :symbol)
      create_attendees
    end

    def create_attendees
      @attendees = @original_attendees.collect do |source|
                   attendee = {
                     :id            => format(source[0]),
                     :last_name     => format(source[:last_name]),
                     :first_name    => format(source[:first_name]),
                     :email_address => format(source[:email_address]),
                     :zipcode       => Zipcode.new(source[:zipcode]).clean,
                     :city          => format(source[:city]),
                     :state         => format(source[:state]),
                     :street        => format(source[:street]),
                     :homephone     => PhoneNumber.new(source[:homephone]).clean,
                     :regdate       => format(source[:regdate]),
                   }
      end
    end

    def format(attr)
      attr.to_s.downcase
    end
  end
end
