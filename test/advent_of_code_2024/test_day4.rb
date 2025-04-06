# frozen_string_literal: true

require "minitest/test"
require "test_helper"

class TestDay4 < Minitest::Test
  include AdventOfCode2024

  def test_part1
    assert_equal 18, Day4.part1(input)
  end

  def test_part2
    assert_equal 9, Day4.part2(input)
  end

  private

  def input
    <<~STR
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    STR
  end
end
