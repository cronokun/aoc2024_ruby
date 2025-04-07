# frozen_string_literal: true

module AdventOfCode2024
  # Day 5: Print Queue
  class Day5
    def self.part1(input) = new(input).part1
    def self.part2(input) = new(input).part2

    def initialize(input)
      @rules, @pages = parse(input)
    end

    def part1
      @pages.filter { correct?(_1) }
            .map { middle_page(_1) }
            .sum
    end

    def part2
      @pages.reject { correct?(_1) }
            .map { correct!(_1) }
            .map { middle_page(_1) }
            .sum
    end

    private

    def correct?(pages)
      printed = []

      pages.reverse.all? do |p|
        (printed << p) - @rules[p] == [p]
      end
    end

    def correct!(pages)
      sorted = []

      until pages.empty?
        x, *xs = pages
        diff = xs - @rules.fetch(x, [])
        pages = xs

        unless diff.empty?
          sorted += correct!(diff)
          pages -= diff
        end

        sorted << x
      end

      sorted
    end

    def middle_page(pages) = pages[pages.length / 2]

    def parse(input)
      rules, pages = input.split("\n\n")
      parsed_rules = rules.scan(/\d+/).map(&:to_i).each_slice(2).sort
      parsed_pages = pages.lines(chomp: true).map { _1.split(",").map(&:to_i) }
      [group_rules(parsed_rules), parsed_pages]
    end

    def group_rules(rules)
      rules.each_with_object(Hash.new([])) { |(k, v), h| h[k] += [v] }
    end
  end
end
