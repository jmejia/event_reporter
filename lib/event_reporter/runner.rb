require_relative 'input'

module EventReporter
  class Runner

    def initialize
      @default_event_attendee_data = 'event_attendees.csv'
      @event_attendees = []
      @queue = Queue.new
      @current_queue = []
    end

    def run
      puts "Event Reporter Initialized"
      input = ""
      while input != "q"
        puts "\nPlease enter a command:"
        input = gets.chomp
        @input = input.split
        puts parse_input
      end
    end

    def parse_input
      case @input[0]
      when "load"  then load
      when "queue" then queue
      when "find"  then find
      when "q"     then puts "\nGoodbye!"
      else "\nNot a valid command"
      end
    end

    def load
      if @input[1].nil?
        @event_attendee_data = @default_event_attendee_data
      else
        @event_attendee_data = @input[1]
      end
      @attendee_list = AttendeeList.new(@event_attendee_data)
      "Loaded #{@event_attendee_data}"
    end

    def queue
      if @input[1].nil?
        "You must include a second command when using 'queue'.\nValid options are: count, clear, print, print by"
      else
        @queue.parse_sub_command(@input[1..-1])
      end
    end

    def find
      if @input[2].nil?
        "'find' requires an <attribute> and <criteria>"
      else
        Find.new(@input[1], @input[2], @attendee_list)
      end
    end

  end
end
