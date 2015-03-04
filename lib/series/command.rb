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

      if n_steps.nil?
        Enumerator.new do |y|
          current = start_index
          while true
            y << current
            current += step_size
          end
        end
      else
        Enumerator.new do |y|
          current = start_index
          n_steps.times do
            y << current
            current += step_size
          end
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

    def loop_enum(enum, stdin = $stdin, stdout = $stdout)
      enum_value, last_x = enum.next, 0
      self.loop(stdin, stdout) do |x|
        n_steps = x - last_x

        # reset if not going forward
        if n_steps < 0
          enum.rewind
          enum_value, last_x, n_steps = enum.next, 0, x
        end

        n_steps.times { enum_value = enum.next }
        last_x = x

        enum_value
      end
    end
  end
end
