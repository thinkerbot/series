require File.expand_path('../test_helper.rb', __FILE__)

class SeriesExeTest < Test::Unit::TestCase
  include ShellTest

  def test_series_prints_usage
    output = `series`
    assert_match(/usage: series/, output)
  end

  #
  # options test
  #

  def test_list_option_shows_available_series
    %w{-l --list}.each do |opt|
      output = `series #{opt}`
      assert_match(/geometric/, output, opt)
    end
  end

  #
  # output test
  #

  def test_series_prints_values_for_series
    assert_script %{
      $ series geometric | head -n 5
      1
      2
      4
      8
      16
    }
  end
end