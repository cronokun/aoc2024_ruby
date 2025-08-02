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
      solve { add_antinode(_1, _2) }
    end

    # Total unique antinode locations including resonant harmonics.
    def part2
      solve { add_all_antinodes(_1, _2) }
    end

    private

    def solve(&block)
      @anthennas.each do |_key, locations|
        locations.combination(2).each do |a1, a2|
          yield a1, a2
        end
      end

      @antinodes.size
    end

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

    def add_all_antinodes(a1, a2)
      x1, y1 = a1
      x2, y2 = a2
      dx = x2 - x1
      dy = y2 - y1

      # Pair of anthennas count as antinodes too!
      @antinodes.add([x1, y1])
      @antinodes.add([x2, y2])

      x = x1 - dx
      y = y1 - dy

      while inside?(x, y)
        @antinodes.add([x, y])
        x -= dx
        y -= dy
      end

      x = x2 + dx
      y = y2 + dy

      while inside?(x, y)
        @antinodes.add([x, y])
        x += dx
        y += dy
      end
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
