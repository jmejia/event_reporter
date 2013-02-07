require 'yaml'
require_relative 'find'
require_relative 'print'
require_relative 'attendee_list'
require_relative 'write'

module EventReporter
  class Runner

    def initialize
      @default_event_attendee_data = 'event_attendees.csv'
      @help = YAML.load_file('help.yml')
      @attendees = []
      @event_attendees = []
      @queue = []
    end

    def run
      puts "\n\n\n***HOLD ON TO YOUR BUTTS***"
      puts "\nType 'q' to quit or 'help' for instructions"
      input = ""
      while input != "q"
        puts "\nPlease enter a command:"
        print "> "
        input = gets.chomp
        @input = input.split
        parse_input
      end
    end

    def parse_input
      case @input[0]
      when "load"  then load
      when "queue" then queue
      when "find"  then find
      when "help"  then help
      when "q"     then puts "Goodbye!"
      else puts "\n*** AH AH AH! YOU DIDN'T SAY THE MAGIC WORD! ***"
      end
    end

    def find
      if @input[2].nil?
        puts "'find' requires an <attribute> and <criteria>"
      else
        @queue = []
        puts @input[2..-1].join(" ")
        @results = Find.new(@attendees, @input[1], @input[2..-1].join(" ")).matches
        @results.each do |result|
          @queue << result
        end
        puts "Found #{@queue.size} results."
      end
    end

    def load
      if @input[1].nil?
        @event_attendee_data = @default_event_attendee_data
      else
        @event_attendee_data = @input[1]
      end
      begin
        @attendees = AttendeeList.new(@event_attendee_data).attendees
        puts "Loaded #{@event_attendee_data}"
      rescue Errno::ENOENT
        puts "Not a valid file. Please try again."
      end
    end

    def queue
      if @input[1].nil?
        puts "You must include a second command when using 'queue'.\nValid options are: count, clear, print, print by"
      else
        case @input[1]
        when "count" then puts @queue.size
        when "print"
          if @input[2] == "by"
            @queue = @queue.sort_by { |attendee| attendee[@input[3].to_sym] }
            Print.new(@queue).to_terminal
          else
            Print.new(@queue).to_terminal
          end
        when "clear" then @queue = []
        when "save"  then Write.new(@queue, @input[3]).csv
        else puts "Not valid sub command"
        end
      end
    end

    def help
      if @input[1].nil?
        puts "\nAvailable commands\n\n"
		  	@help.each do |k, v|
          puts "#{k.ljust(15)}: #{v}"
        end
		  elsif @input[2]
        puts @help[@input[1..2].join(" ")]
      else
		  	puts @help[@input[1]]
		  end
    end

  end
end
