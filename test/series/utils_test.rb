require File.expand_path('../../test_helper.rb', __FILE__)
require 'series/utils'

# Test Constants
module ConstName
end

module ConstantNest
  module ConstName
  end
end

class UtilsTest < Test::Unit::TestCase
  include Series::Utils
  include FileTestUtils

  #
  # split test
  #

  def test_split_splits_path_along_colon
    assert_equal ["a/b", "c"], split("a/b:c")
  end

  def test_split_returns_arrays
    assert_equal ["a/b", "c"], split(["a/b", "c"])
  end

  #
  # glob test
  #

  def test_glob_returns_enum_for_files_matching_pattern_with_path
    Dir.mktmpdir do |dir|
      one = File.join(dir, "one")
      two = File.join(dir, "two")
      a = create(one, "a.rb")
      b = create(one, "b.rb")
      c = create(two, "c.rb")
          create(two, "d.txt")

      path = "#{one}:#{two}"
      assert_equal [[one, a], [one, b], [two, c]], glob('*.rb', path).to_a
    end
  end

  #
  # constantize test
  #

  def test_constantize_returns_the_existing_constant
    # ::ConstName
    assert_equal ConstName, constantize("ConstName")
    assert_equal ConstName, constantize("::ConstName")
    assert_equal ConstName, constantize("Object::ConstName")

    # ConstantNest::ConstName
    assert_equal ConstantNest::ConstName, constantize("ConstantNest::ConstName")
    assert_equal ConstantNest::ConstName, constantize("::ConstantNest::ConstName")
    assert_equal ConstantNest::ConstName, constantize("Object::ConstantNest::ConstName")
  end

  def test_constantize_raise_error_for_invalid_constant_names
    assert_raises(NameError) { constantize("") }
    assert_raises(NameError) { constantize("::") }
    assert_raises(NameError) { constantize("const_name") }
  end

  def test_constantize_raises_error_if_constant_does_not_exist
    assert_raises(NameError) { constantize("Non::Existant") }
    assert_raises(NameError) { constantize("::Non::Existant") }
  end

  def test_constantize_yields_current_const_and_missing_constant_names_to_the_block
    was_in_block = false
    constantize("Non::Existant") do |const, const_names|
      assert_equal Object, const
      assert_equal ["Non", "Existant"], const_names
      was_in_block = true
    end
    assert was_in_block

    was_in_block = false
    constantize("ConstName::Non::Existant") do |const, const_names|
      assert_equal ConstName, const
      assert_equal ["Non", "Existant"], const_names
      was_in_block = true
    end
    assert was_in_block
  end

  def test_constantize_returns_return_value_of_block_when_yielding_to_the_block
    assert_equal(ConstName, constantize("ConstName") { false })
    assert_equal(false, constantize("Non::Existant") { false })
  end
end