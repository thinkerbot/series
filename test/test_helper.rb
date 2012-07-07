require 'rubygems'
require 'bundler'
Bundler.setup

require 'test/unit'
require 'tmpdir'
require 'fileutils'

if name = ENV['NAME']
  ARGV << "--name=#{name}"
end

module FileTestUtils
  def create(*file_path)
    file = File.join(*file_path)
    FileUtils.mkdir_p File.dirname(file)

    if block_given?
      File.open(file, 'w') {|io| yield(io) }
    else
      FileUtils.touch file
    end

    file
  end
end