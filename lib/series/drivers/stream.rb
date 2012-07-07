module Series
  module Drivers
    class Stream
      attr_reader :io

      def initialize(io = $stdin)
        @io = io
      end

      def each
        while line = io.gets
          yield line.to_i
        end
      end
    end
  end
end