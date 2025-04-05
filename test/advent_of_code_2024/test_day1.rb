# frozen_string_literal: true

require "test_helper"

class TestDay1 < Minitest::Test
  def test_part1
    assert_equal 11, AdventOfCode2024::Day1.part1(input)
  end

  def test_part2
    assert_equal 31, AdventOfCode2024::Day1.part2(input)
  end

  private

  def input
    <<~STR
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    STR
  end
end
