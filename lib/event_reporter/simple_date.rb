module EventReporter
  class SimpleDate

    def initialize(date)
      @date = date
    end

    def clean
      DateTime.strptime(@date, '%m/%d/%y %k:%M').to_s
    end
  end
end
