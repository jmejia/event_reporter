module EventReporter
  class Queue
    attr_accessor :current

    def initialize(current=[])
      @current = current
    end

  end
end
