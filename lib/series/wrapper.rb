require "series/api"

module Series
  class Wrapper
    include Series::Api

    attr_reader :reciever

    def initialize(reciever)
      @reciever = reciever
      reset
    end

    def call(n)
      reciever.call(n)
    end
  end
end
