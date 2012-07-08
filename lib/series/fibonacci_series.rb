require 'series/api'

module Series
  # Describes a fibonacci series.
  class FibonacciSeries
    include Series::Api

    attr_reader :curr

    def initialize
      reset
    end

    def reset
      @curr = 0
      @succ = 1
      super
    end

    def step
      @curr, @succ = @succ, @curr + @succ
      super
    end

    def call(n)
      reset
      n.times { step }
      curr
    end
  end
end