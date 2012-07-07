require File.expand_path('../test_helper.rb', __FILE__)

class SeriesExeTest < Test::Unit::TestCase

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
    output = `series geometric | head`
    assert_equal %w{
      1   2   4   8  16
      32 64 128 256 512
    }, output.split("\n")
  end
end