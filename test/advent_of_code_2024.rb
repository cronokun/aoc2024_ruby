# frozen_string_literal: true

require "test_helper"

class TestAdventOfCode2024 < Minitest::Test
  def test_day1_answers
    input = File.read("./test/inputs/day1")
    assert_equal 2_192_892, AdventOfCode2024::Day1.part1(input)
    assert_equal 22_962_826, AdventOfCode2024::Day1.part2(input)
  end

  def test_day2_answers
    input = File.read("./test/inputs/day1")
    assert_equal 22962826, AdventOfCode2024::Day1.part2(input)
  end
end
