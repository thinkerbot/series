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
  # -m test
  #

  def test_m_option_sets_min
    assert_script %{
      $ series geometric -m 2 | head -n 3
      4.0
      8.0
      16.0
    }
  end

  def test_m_option_displays_error_for_negative_values
    assert_script %{
      $ series geometric -m -1     # [1]
      invalid -m (cannot be negative): -1
    }
  end

  def test_m_option_displays_error_for_non_numeric_input
    assert_script %{
      $ series geometric -m abc    # [1]
      invalid -m (non-numeric): "abc"
    }
  end

  #
  # -n test
  #

  def test_n_option_sets_max
    assert_script %{
      $ series geometric -n 2
      1.0
      2.0
      4.0
    }
  end

  def test_n_option_treats_negative_as_infinite
    assert_script %{
      $ series geometric -n -1 | head -n 5
      1.0
      2.0
      4.0
      8.0
      16.0
    }
  end

  def test_n_option_displays_error_for_non_numeric_input
    assert_script %{
      $ series geometric -n abc    # [1]
      invalid -n (non-numeric): "abc"
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