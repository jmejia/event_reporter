module EventReporter
  class PhoneNumber
    attr_reader :phone_number
    def initialize(phone)
      @phone = phone
    end

    def clean
      @phone.gsub(/\D/, "").match(/^1?(\d{10,})/) do |clean_num|
        clean_num[1] if clean_num[1].size == 10
      end
    end
  end
end
