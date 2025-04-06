# frozen_string_literal: true

module AdventOfCode2024
  # Day 4: Ceres Search
  class Day4
    def self.part1(input) = new(input).part1
    def self.part2(input) = new(input).part2

    def initialize(input)
      @input = input
      @lines = input.lines(chomp: true)
    end

    def part1
      count(horizontal) + count(vertical) + count(diagonal1) + count(diagonal2)
    end

    def part2
      n = @lines.length - 2
      res = 0

      (1..n).each do |y|
        (1..n).each do |x|
          res += 1 if xmas?(x, y)
        end
      end

      res
    end

    private

    # ---- Part 1 ----

    def count(str) = str.scan("XMAS").length + str.scan("SAMX").length

    def horizontal = @input

    def vertical
      @lines
        .map(&:chars)
        .transpose
        .map(&:join)
        .join("\n")
    end

    def diagonal1
      rot45(@lines.map(&:chars))
    end

    def diagonal2
      rot45(@lines.map { _1.chars.reverse })
    end

    def rot45(xs)
      xs.transpose
        .flatten
        .group_by.with_index { |_, k| k.divmod(xs.size).inject(:+) }
        .values
        .map(&:join)
        .join("\n")
    end

    # All X-MAS variants:
    #
    #   S.S  S.M  M.S  M.M
    #   .A.  .A.  .A.  .A.
    #   M.M  S.M  M.S  S.S
    #
    def xmas?(x, y)
      return false unless @lines[y][x] == "A"

      %w[SSMM SMSM MSMS MMSS].include?([
        @lines[y - 1][x - 1],
        @lines[y - 1][x + 1],
        @lines[y + 1][x - 1],
        @lines[y + 1][x + 1]
      ].join)
    end
  end
end
