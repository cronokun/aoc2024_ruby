# frozen_string_literal: true

module AdventOfCode2024
  # Day 7: Bridge Repair
  class Day7
    def self.part1(input) = new(input, [:+, :*]).part1
    def self.part2(input) = new(input, []).part2

    def initialize(input, ops)
      @input = parse(input)
      @ops = ops
    end

    def part1
      @input
        .filter { valid?(*_1) }
        .map { _1.first }
        .sum
    end

    def part2 = 0

    private

    def valid?(result, xs)
      @ops.repeated_permutation(xs.size - 1) do |ops|
        return true if valid_equation?(result, xs, ops)
      end

      false
    end

    def valid_equation?(expected, nums, ops)
      x, *xs = nums

      actual =
        ops.zip(xs).reduce(x) do |res, (op, x)|
          case op
          when :+
            res + x
          when :*
            res * x
          end
        end

      actual == expected
    end

    def parse(input)
      input.lines(chomp: true).map { parse_line _1 }
    end

    def parse_line(line)
      result, nums = line.split(": ")
      xs = nums.split(" ").map(&:to_i)
      [result.to_i, xs]
    end
  end
end
