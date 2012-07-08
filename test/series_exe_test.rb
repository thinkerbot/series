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
      1.0
      2.0
      4.0
      8.0
      16.0
    }
  end

  def test_series_passes_args_to_series
    assert_script %{
      $ series geometric 2 4 | head -n 5
      2.0
      8.0
      32.0
      128.0
      512.0
    }
  end

  def test_series_with_fibonacci
    assert_script %{
      $ series fibonacci | head -n 5
      0
      1
      1
      2
      3
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
      1.0
      2.0
      4.0
      8.0
      16.0
    }
  end

  def test_n_option_with_n_equal_0_prints_nothing
    assert_script %{
      $ series geometric -n 0
    }
  end

  def test_n_option_allows_range_of_x
    assert_script %{
      $ series geometric -n 2..5
      4.0
      8.0
      16.0
      32.0
    }
  end

  def test_n_option_allows_exclusive_range_of_x
    assert_script %{
      $ series geometric -n 2...5
      4.0
      8.0
      16.0
    }
  end

  def test_n_option_with_inverted_range
    assert_script %{
      $ series geometric -n 5..2
    }
  end

  def test_n_option_with_matching_range
    assert_script %{
      $ series geometric -n 0..0
      1.0
    }
  end

  def test_n_option_with_matching_exlusive_range_prints_nothing
    assert_script %{
      $ series geometric -n 0...0
    }
  end

  def test_n_option_allows_negative_values
    assert_script %{
      $ series geometric -n -4..-1
      0.0625
      0.125
      0.25
      0.5
    }
  end

  def test_n_option_raises_error_for_invalid_input
    assert_script %{
      $ series geometric -n abc    # [1]
      invalid value for -n: "abc"
    }
  end

  def test_n_option_with_dash_reads_x_from_stdin
    assert_script %{
      $ series geometric -n - <<DOC
      > 1
      > 3
      > 5
      > DOC
      2.0
      8.0
      32.0
    }
  end

  #
  # -r test
  #

  def test_r_option_rounds_output_to_integer
    assert_script %{
      $ series geometric -r | head -n 5
      1
      2
      4
      8
      16
    }
  end

  #
  # -x test
  #

  def test_x_option_prints_x_with_y
    assert_script %{
      $ series geometric -x | head -n 5
      0 1.0
      1 2.0
      2 4.0
      3 8.0
      4 16.0
    }
  end
end