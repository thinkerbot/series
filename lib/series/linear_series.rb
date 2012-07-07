module Series
  # Describes a linear series.
  class LinearSeries
    attr_reader :m
    attr_reader :b

    def initialize(m = 0, b = 0)
      @m = m.to_f
      @b = b.to_f
    end

    def [](x)
      m * x + b
    end

    def sum(n=nil)
      if n.nil?
        nil
      else
        sum = 0
        n.times {|i| sum += self[i] }
        sum
      end
    end
  end
end