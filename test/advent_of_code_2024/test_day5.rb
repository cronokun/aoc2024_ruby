# frozen_string_literal: true

require "minitest/test"
require "test_helper"

class TestDay5 < Minitest::Test
  include AdventOfCode2024

  def test_part1
    assert_equal 143, Day5.part1(input)
  end

  def test_part2
    assert_equal 123, Day5.part2(input)
  end

  private

  def input
    <<~STR
      47|53
      97|13
      97|61
      97|47
      75|29
      61|13
      75|53
      29|13
      97|29
      53|29
      61|53
      97|53
      61|29
      47|13
      75|47
      97|75
      47|61
      75|61
      47|29
      75|13
      53|13

      75,47,61,53,29
      97,61,53,29,13
      75,29,13
      75,97,47,61,53
      61,13,29
      97,13,75,29,47
    STR
  end
end
