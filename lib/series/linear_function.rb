module Series
  # Describes a linear series.
  class LinearFunction
    attr_reader :m
    attr_reader :b

    def initialize(m = 0, b = 0)
      @m = m.to_f
      @b = b.to_f
    end

    def call(x)
      m * x + b
    end
  end
end