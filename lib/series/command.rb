module Series
  module Command
    module_function

    DEFAULT_OPTIONS = {
      :n_steps    => 8,
      :offset     => 0,
      :step_size  => 1,
    }

    module_function

    def setup(config)
    end

    def options(overrides = {})
      DEFAULT_OPTIONS.merge(overrides)
    end

    def driver(options = {})
      n_steps = options.fetch(:n_steps)
      start_index = options.fetch(:offset)
      step_size = options.fetch(:step_size)

      Enumerator.new do |y|
        current = start_index
        n_steps.times do
          y << current
          current += step_size
        end
      end
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
