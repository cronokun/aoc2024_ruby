# frozen_string_literal: true

module AdventOfCode2024
  class Day1
    def self.part1(input)
      xs = input.split.map(&:to_i).each_slice(2).to_a.transpose

      case xs
      in [as, bs]
        as.sort.zip(bs.sort).sum { |a, b| (a - b).abs }
      end
    end
  end
end
