require File.expand_path('../test_helper.rb', __FILE__)
require 'series'

class SeriesTest < Test::Unit::TestCase
  include FileTestUtils

  #
  # list test
  #

  def test_list_returns_list_of_program_files_ending_in__series_dot_rb
    Dir.mktmpdir do |dir|
      one = File.join(dir, "one")
      two = File.join(dir, "two")
      a = create(one, "a_series.rb")
      b = create(one, "b_series.rb")
      c = create(two, "c_series.rb")
          create(two, "d.rb")

      path = "#{one}:#{two}"

      assert_equal({
        'a' => {:require => a, :const_name => '::ASeries'},
        'b' => {:require => b, :const_name => '::BSeries'},
        'c' => {:require => c, :const_name => '::CSeries'},
      }, Series.list(path))
    end
  end
end