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

  def test_day4_answers
    input = File.read("./test/inputs/day4")
    assert_equal 2_434, Day4.part1(input)
    assert_equal 1_835, Day4.part2(input)
  end

  def test_day5_answers
    input = File.read("./test/inputs/day5")
    assert_equal 5_108, Day5.part1(input)
    assert_equal 7_380, Day5.part2(input)
  end

  def test_day6_answers
    input = File.read("./test/inputs/day6")
    assert_equal 5_145, Day6.part1(input)
    assert_equal 1_523, Day6.part2(input)
  end

  def test_day7_answers
    input = File.read("./test/inputs/day7")
    assert_equal 12553187650171, Day7.part1(input)
    assert_equal 96779702119491, Day7.part2(input)
  end

  def test_day8_answers
    input = File.read("./test/inputs/day8")
    assert_equal 220, Day8.part1(input)
    assert_equal 813, Day8.part2(input)
  end
end
