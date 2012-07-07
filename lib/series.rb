require "series/version"
require "series/utils"
require "series/drivers/counter"
require "series/drivers/stream"

module Series
  module_function

  # The default path is the SERIES_PATH ENV variable, or the series directory
  # for this project.
  def default_path
    ENV['SERIES_PATH'] || [File.dirname(__FILE__.chomp('.rb'))]
  end

  # Lists available series along path
  def list(path = default_path)
    list = {}
    Utils.glob("**/*_series.rb", path) do |dir, file|
      name = File.basename(file, "_series.rb")
      relative_path = file[dir.length, file.length - dir.length - 3]
      list[name] = {:require => file, :const_name => Utils.camelize(relative_path) }
    end
    list
  end

  def driver(input = nil)
    case input
    when nil
      Drivers::Counter.new
    when "-"
      Drivers::Stream.new
    when /^\d+$/
      Drivers::Counter.new(0, input.to_i - 1)
    when /^(-?\d+)..(-?\d+)$/
      x = $1.to_i
      n = $2.to_i
      Drivers::Counter.new(x, n)
    when /^(-?\d+)...(-?\d+)$/
      x = $1.to_i
      n = $2.to_i - 1
      Drivers::Counter.new(x, n)
    else
      nil
    end
  end

  def init(series_name, *args)
    desc = list[series_name]

    if desc.nil?
      raise "unknown series: #{series_name}"
    end

    require_file = desc[:require]
    const_name   = desc[:const_name]

    require require_file
    klass = Utils.constantize(const_name)
    klass.new(*args)
  end
end
