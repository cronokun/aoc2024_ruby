# frozen_string_literal: true

require "test_helper"

class TestDay1 < Minitest::Test
  def test_part1
    input = "3   4\n4   3\n2   5\n1   3\n3   9\n3   3"
    assert_equal 11, AdventOfCode2024::Day1.part1(input)
  end
end
