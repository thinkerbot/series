module Series
  # Describes a fibonacci series.
  class FibonacciSeries

    attr_reader :curr
    attr_reader :n

    def initialize
      reset
    end

    def reset
      @curr = 0
      @succ = 1
      @n = 0
    end

    def step
      @curr, @succ = @succ, @curr + @succ
      @n += 1
    end

    def [](n)
      reset
      n.times { step }
      curr
    end
  end
end