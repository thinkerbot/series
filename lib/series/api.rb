module Series
  module Api
    attr_reader :n

    def reset
      @n = 0
    end

    def step
      @n += 1
    end

    def curr
      call(n)
    end

    def call(n)
      raise NotImplementedError
    end

    module_function

    def satisfied?(obj)
      obj.respond_to?(:reset) &&
      obj.respond_to?(:step) &&
      obj.respond_to?(:curr)
    end
  end
end
