require "series/version"

module Series
  module_function

  def version
    "series version %s (%s)" % [VERSION, RELDATE]
  end
end
