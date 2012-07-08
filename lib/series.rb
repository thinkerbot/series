require "series/version"
require "series/utils"
require "series/wrapper"

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
    Utils.glob("**/*_function.rb", path) do |dir, file|
      name = File.basename(file, "_function.rb")
      relative_path = file[dir.length, file.length - dir.length - 3]
      list[name] = {:require => file, :const_name => Utils.camelize(relative_path) }
    end
    list
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
    instance = klass.new(*args)

    unless instance.kind_of?(Api)
      instance = Wrapper.new(instance)
    end

    instance
  end
end
