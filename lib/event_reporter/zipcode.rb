module EventReporter
  class Zipcode

    def initialize(zipcode)
      @zipcode = zipcode
    end

    def clean
      @zipcode.to_s.rjust(5,"0")[0..4]
    end
  end
end
