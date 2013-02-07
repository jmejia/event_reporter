require_relative 'phone_number'
require_relative 'zipcode'
require_relative 'simple_date'

module EventReporter
  class Attendee
    attr_reader :id, :last_name, :first_name, :email_address, :zipcode, :city, :state, :street, :homephone, :regdate

    def initialize(id, last_name, first_name, email_address, zipcode, city, state, street, homephone, regdate)
      @id            = id
      @last_name     = standard_format(last_name)
      @first_name    = standard_format(first_name)
      @email_address = standard_format(email_address)
      @zipcode       = Zipcode.new(zipcode).clean
      @city          = standard_format(city)
      @state         = standard_format(state)
      @street        = standard_format(street)
      @homephone     = PhoneNumber.new(homephone).clean
      @regdate       = SimpleDate.new(regdate).clean
    end

    def standard_format(attr)
      attr.to_s.downcase
    end

  end
end
