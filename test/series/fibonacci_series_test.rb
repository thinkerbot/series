require File.expand_path('../../test_helper.rb', __FILE__)
require 'series/Fibonacci_series'

class FibonacciSeriesTest < Test::Unit::TestCase
  FibonacciSeries = Series::FibonacciSeries

  TEN_VALUES = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

  attr_accessor :series

  def setup
    @series = FibonacciSeries.new
  end

  #
  # call test
  #

  def test_call_returns_series_value_at_input
    TEN_VALUES.each_with_index do |value, n|
      assert_equal value, series.call(n)
    end
  end

  #
  # step test
  #

  def test_succ_returns_next_value_in_series
    TEN_VALUES.each_with_index do |value, n|
      assert_equal value, series.curr
      series.step
    end
  end
end