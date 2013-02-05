module EventReporter
  class Queue
    def initialize(*args)
      @current_queue = args
    end

    def parse_sub_command(args)
      case args[0]
      when "count" then count
      when "clear" then @current_queue = []
      else "not valid sub command"
      end
    end

    def count
      @current_queue.count
    end
  end
end
