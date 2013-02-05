require 'csv'

module EventReporter
  class AttendeeList
    attr_reader :attendees

    def initialize(file)
      @attendees = CSV.open(file, :headers => true, :header_converters => :symbol)
    end
  end
end
