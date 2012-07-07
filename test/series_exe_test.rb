require File.expand_path('../test_helper.rb', __FILE__)

class SeriesExeTest < Test::Unit::TestCase
  include ShellTest

  def test_series_prints_usage
    output = `series`
    assert_match(/usage: series/, output)
  end

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

  #
  # -l, --list test
  #

  def test_list_option_shows_available_series
    %w{-l --list}.each do |opt|
      output = `series #{opt}`
      assert_match(/geometric/, output, opt)
    end
  end

  #
  # -n test
  #

  def test_n_option_limits_x
    assert_script %{
      $ series geometric -n 5
      1
      2
      4
      8
      16
    }
  end

  def test_n_option_allows_range_of_x
    assert_script %{
      $ series geometric -n 2..5
      4
      8
      16
    }
  end

  def test_n_option_allows_exclusive_range_of_x
    assert_script %{
      $ series geometric -n 2...5
      4
      8
    }
  end

  def test_n_option_raises_error_for_invalid_input
    assert_script %{
      $ series geometric -n abc    # [1]
      invalid value for -n: "abc"
    }
  end

  #
  # -x test
  #

  def test_x_option_prints_x_with_y
    assert_script %{
      $ series geometric -x | head -n 5
      0 1
      1 2
      2 4
      3 8
      4 16
    }
  end
end