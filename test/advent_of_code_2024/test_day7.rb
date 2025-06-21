# frozen_string_literal: true

require "test_helper"

class TestDay7 < Minitest::Test
  include AdventOfCode2024

  def test_part1
    assert_equal 3_749, Day7.part1(input)
  end

  def test_part2
    assert_equal 11_387, Day7.part2(input)
  end

  private

  def input
    <<~STR
      190: 10 19
      3267: 81 40 27
      83: 17 5
      156: 15 6
      7290: 6 8 6 15
      161011: 16 10 13
      192: 17 8 14
      21037: 9 7 18 13
      292: 11 6 16 20
    STR
  end
end
