module EventReporter
  class Find
    def initialize(attendees, attr, criteria)
      @attendees = attendees
      @attr      = attr
      @criteria  = criteria
    end

    def matches
      @attendees.select do |attendee|
        attendee[@attr.to_sym] == @criteria.downcase
      end
    end
  end
end
