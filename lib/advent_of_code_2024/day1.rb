# frozen_string_literal: true

module AdventOfCode2024
  # Day1: Historian Hysteria
  class Day1
    def self.part1(input)
      new(input).part1
    end

    def self.part2(input)
      new(input).part2
    end

    def initialize(input)
      case parse(input)
      in [as, bs]
        @as = as.sort
        @bs = bs.sort
      end
    end

    def part1
      @as.zip(@bs).sum { |a, b| (a - b).abs }
    end

    def part2
      bs = @bs.tally
      @as.sum { |a| a * bs.fetch(a, 0) }
    end

    private

    def parse(input)
      input.split.map(&:to_i).each_slice(2).to_a.transpose
    end
  end
end
