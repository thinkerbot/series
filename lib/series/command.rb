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

    def loop(stdin = $stdin, stdout = $stdout)
      while line = stdin.gets
        line.strip!
        next if line.empty?
        x = Integer(line)
        y = yield(x)
        stdout.puts y
      end
    end
  end
end
