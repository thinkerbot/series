module Series
  module Drivers
    class Counter
      attr_reader :min
      attr_reader :max

      def initialize(min = 0, max = nil)
        @min = min
        @max = max
      end

      def each
        x = min

        if max.nil?
          while true
            yield x
            x += 1
          end
        else
          while x <= max
            yield x
            x += 1
          end
        end
      end
    end
  end
end