# frozen_string_literal: true

require "test_helper"

class TestAdventOfCode2024 < Minitest::Test
  def test_day1_answers
    input = File.read("./test/inputs/day1")
    assert_equal 2192892, AdventOfCode2024::Day1.part1(input)
  end
end
