# frozen_string_literal: true

require "test_helper"

class TestDay6 < Minitest::Test
  include AdventOfCode2024

  def test_part1
    assert_equal 41, Day6.part1(input)
  end

  def test_part2
    assert_equal 6, Day6.part2(input)
  end

  private

  def input
    <<~STR
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
    STR
  end
end
