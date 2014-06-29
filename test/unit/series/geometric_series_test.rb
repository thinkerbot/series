require File.expand_path('../../helper.rb', __FILE__)
require 'series/geometric_series'

class GeometricSeriesTest < Test::Unit::TestCase
  GeometricSeries = Series::GeometricSeries

  def test_initialize_sets_a_and_r
    series = GeometricSeries.new(1, 2)
    assert_equal 1, series.a
    assert_equal 2, series.r
  end

  def test_default_a_is_1_and_default_r_is_2
    series = GeometricSeries.new
    assert_equal 1, series.a
    assert_equal 2, series.r
  end

  #
  # call test
  #

  def test_AGET_returns_series_value_at_input
    series = GeometricSeries.new(2, 3)
    assert_equal 2,  series.call(0)
    assert_equal 6,  series.call(1)
    assert_equal 18, series.call(2)
  end

  #
  # sum test
  #

  def test_sum_returns_the_sum_of_n_terms
    series = GeometricSeries.new(2, 3)
    assert_equal 26, series.sum(3)
  end

  def test_sum_without_n_returns_sum_of_the_series_if_abs_r_is_less_than_1
    series = GeometricSeries.new(2, 0.5)
    assert_equal 4.0, series.sum

    series = GeometricSeries.new(3, -0.5)
    assert_equal 2.0, series.sum
  end

  def test_sum_without_n_returns_nil_if_abs_r_is_greater_than_1
    series = GeometricSeries.new(2, 1)
    assert_equal nil, series.sum

    series = GeometricSeries.new(2, -1)
    assert_equal nil, series.sum

    series = GeometricSeries.new(2, 2)
    assert_equal nil, series.sum
  end
end