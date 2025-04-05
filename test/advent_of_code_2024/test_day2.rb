# frozen_string_literal: true

require "test_helper"

class TestDay2 < Minitest::Test
  include AdventOfCode2024

  def test_part1
    assert_equal 2, Day2.part1(input)
  end

  def test_part2
    assert_equal 4, Day2.part2(input)
  end

  private

  def input
    <<~STR
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
    STR
  end
end
