require_relative 'attendee_list'
require_relative 'queue'

module EventReporter
  class Input
    def initialize(input, attendee_list)
      @input = input.split
      @command = @input[0]
      @attendee_list = attendee_list
    end

    def load
      filename = @input[1].nil? ? 'event_attendees.csv' : @input[1]
      @attendee_list = AttendeeList.new(filename)
    end

    def queue
      if @input[1].nil?
        "You must include a second command when using 'queue'.\nValid options are: count, clear, print, print by"
      else
        Queue.new.parse_sub_command(@input[1..-1])
      end
    end

    def find
      if @input[2].nil?
        "'find' requires an <attribute> and <criteria>"
      else
        @attendee_list
        #Find.new(@attendee_list).parse_sub_command(input[1..-1])
      end
    end

    def parse_command
      case @command
      when "load"  then load
      when "queue" then queue
      when "find"  then find
      when "q"     then puts "\nGoodbye!"
      else "\nnot a valid command"
      end
    end


  end
end
