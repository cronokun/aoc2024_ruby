# frozen_string_literal: true

module AdventOfCode2024
  # Day 2: Red-Nosed Reports
  class Day2
    def self.part1(input) = new(input).part1
    def self.part2(input) = new(input).part2

    def initialize(input)
      @input = parse(input)
    end

    def part1
      @input.count { |xs| safe?(xs) }
    end

    def part2
      @input.count { |xs| maybe_safe?(xs) }
    end

    private

    def safe?(xs)
      diffs = xs.each_cons(2).map { |p| p[0] - p[1] }
      is_safe_level = diffs.all? { |d| d.abs >= 1 and d.abs <= 3 }
      is_same_ord = diffs.sum.abs == diffs.map(&:abs).sum
      is_safe_level and is_same_ord
    end

    def maybe_safe?(xs)
      variants(xs).any? { |l| safe?(l) }
    end

    # Drop every element in the list.
    def variants(xs)
      (0..xs.length).map do |i|
        xs1 = xs.clone
        xs1.delete_at(i)
        xs1
      end << xs
    end

    def parse(input)
      input.split("\n").map(&:split).map { |xs| xs.map(&:to_i) }
    end
  end
end
