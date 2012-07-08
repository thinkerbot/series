module Series
  # Describes a geometric series.
  class GeometricSeries
    attr_reader :a
    attr_reader :r
    attr_reader :n

    def initialize(a = 1, r = 2)
      @a = a.to_f
      @r = r.to_f
      reset
    end

    def reset
      @n = 0
    end

    def step
      @n += 1
    end

    def curr
      self[@n]
    end

    def [](n)
      a * r ** n
    end

    def convergent?
      r.abs < 1
    end

    def sum(n=nil)
      if n.nil?
        convergent? ? (a / (1.0 - r)) : nil
      else
        sum = 0
        n.times {|i| sum += self[i] }
        sum
      end
    end
  end
end