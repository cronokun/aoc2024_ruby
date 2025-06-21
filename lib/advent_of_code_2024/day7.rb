# frozen_string_literal: true

module AdventOfCode2024
  # Day 7: Bridge Repair
  class Day7
    def self.part1(input) = new(input, [:+, :*]).solve
    def self.part2(input) = new(input, [:+, :*, :|]).solve

    def initialize(input, ops)
      @input = parse(input)
      @ops = ops
    end

    def better_solve
      @input
        .filter { |(res, nums)| valid?(res, nums) }
    end

    def solve
      @input
        .filter { valid?(*_1) }
        .map { _1.first }
        .sum
    end

    private

    def valid?(expected, nums)
      results =
        nums.drop(1).reduce(nums.take(1)) do |acc, x|
          res = []

          for op in @ops do
            for r in acc do
              res.push(apply_op(op, r, x))
            end
          end

          res.reject { _1 > expected }
        end

      results.any? { _1 == expected }
    end

    def apply_op(op, a, b)
      case op
      when :+ then a + b
      when :* then a * b
      when :| then "#{a}#{b}".to_i
      end
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
