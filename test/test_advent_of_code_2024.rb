# frozen_string_literal: true

require "test_helper"

class TestAdventOfCode2024 < Minitest::Test
  include AdventOfCode2024

  def test_day1_answers
    input = File.read("./test/inputs/day1")
    assert_equal 2_192_892, Day1.part1(input)
    assert_equal 22_962_826, Day1.part2(input)
  end

  def test_day2_answers
    input = File.read("./test/inputs/day2")
    assert_equal 663, Day2.part1(input)
    assert_equal 692, Day2.part2(input)
  end

  def test_day3_answers
    input = File.read("./test/inputs/day3")
    assert_equal 170_807_108, Day3.part1(input)
    assert_equal 74_838_033, Day3.part2(input)
  end
end
