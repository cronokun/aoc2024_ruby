# frozen_string_literal: true

require "test_helper"

class TestDay3 < Minitest::Test
  include AdventOfCode2024

  def test_part1
    input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    assert_equal 161, Day3.part1(input)
  end

  def test_part2
    input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
    assert_equal 48, Day3.part2(input)
  end
end
