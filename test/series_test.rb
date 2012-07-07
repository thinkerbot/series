require File.expand_path('../test_helper.rb', __FILE__)
require 'series'

class SeriesTest < Test::Unit::TestCase
  include ShellTest::FileMethods

  #
  # list test
  #

  def test_list_returns_list_of_program_files_ending_in__series_dot_rb
    one = path("one")
    two = path("two")

    a = prepare("one/a_series.rb")
    b = prepare("one/b_series.rb")
    c = prepare("two/c_series.rb")
        prepare("two/d.rb")

    assert_equal({
      'a' => {:require => a, :const_name => '::ASeries'},
      'b' => {:require => b, :const_name => '::BSeries'},
      'c' => {:require => c, :const_name => '::CSeries'},
    }, Series.list("#{one}:#{two}"))
  end
end