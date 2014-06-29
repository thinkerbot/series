module Series
  module Command
    module_function

    DEFAULT_OPTIONS = {
    }

    module_function

    def setup(config)
    end

    def options(overrides = {})
      DEFAULT_OPTIONS.merge(overrides)
    end
  end
end
