# frozen_string_literal: true

module AdventOfCode2024
  # Day 3: Mull It Over
  class Day3
    def self.part1(input) = new(input).part1
    def self.part2(input) = new(input).part2

    def initialize(input)
      @input = input
    end

    def part1
      @input
        .scan(/mul\(\d+,\d+\)/)
        .map { parse_mul(_1) }
        .sum
    end

    def part2
      @input
        .scan(/do\(\)|don't\(\)|mul\(\d+,\d+\)/)
        .reduce([0, true]) { parse_instruction(_1, _2) }
        .first
    end

    private

    def parse_mul(instruction)
      instruction.match(/mul\((\d+),(\d+)\)/).captures.map(&:to_i).reduce(:*)
    end

    def parse_instruction(acc, instruction)
      case instruction
      when "do()"
        [acc[0], true]
      when "don't()"
        [acc[0], false]
      else
        acc[1] ? [acc[0] + parse_mul(instruction), true] : acc
      end
    end
  end
end
