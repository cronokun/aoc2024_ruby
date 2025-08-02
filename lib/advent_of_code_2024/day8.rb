# frozen_string_literal: true

module AdventOfCode2024
  # Day 8: Resonant Collinearity
  class Day8
    def self.part1(input) = new(input).part1
    def self.part2(input) = new(input).part2

    def initialize(input)
      @antinodes = Set.new
      parse!(input)
    end

    # Total unique antinode locations.
    def part1
      antinodes = Set.new

      @anthennas.each do |_key, locations|
        locations.combination(2).each do |a1, a2|
          add_antinode(a1, a2)
        end
      end

      @antinodes.size
    end

    def part2
      :FIXME
    end

    private

    def add_antinode(a1, a2)
      x1, y1 = a1
      x2, y2 = a2
      dx = x2 - x1
      dy = y2 - y1
      ax = x1 - dx
      bx = x2 + dx
      ay = y1 - dy
      by = y2 + dy
      @antinodes.add([ax, ay]) if inside?(ax, ay)
      @antinodes.add([bx, by]) if inside?(bx, by)
    end

    def inside?(x, y)
      x >= 0 && x < @size && y >= 0 && y < @size
    end

    def parse!(input)
      memo = Hash.new { |hash, key| hash[key] = [] }
      x = y = 0

      input.each_char do |ch|
        case ch
        when "\n"
          x = 0
          y += 1
        when "."
          x += 1
        else
          memo[ch] << [x, y]
          x += 1
        end
      end

      @anthennas = memo
      @size = y
    end
  end
end
