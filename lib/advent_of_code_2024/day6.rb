# frozen_string_literal: true

module AdventOfCode2024
  # Day6: Guard Gallivant
  module Day6
    class Guard
      attr_reader :direction, :location, :path

      def initialize(location, direction = :up)
        @location = location
        @direction = direction
        @path = []
      end

      def move_to(loc, dir)
        add_path_to(*loc)
        @location = loc
        @direction = dir
      end

      def visited = @path.map(&:first).to_set

      private

      def add_path_to(nx, ny)
        x, y = @location

        locations =
          case @direction
          when :up    then (y.pred).downto(ny).map { |y1| [x, y1] }
          when :down  then (y.succ).upto(ny).map { |y1| [x, y1] }
          when :left  then (x.pred).downto(nx).map { |x1| [x1, y] }
          when :right then (x.succ).upto(nx).map { |x1| [x1, y] }
          end

        locations.each { |loc| @path << [loc, @direction] }
      end
    end

    class Area
      def initialize(size, obstacles)
        @obstacles = prepare_obstacles(obstacles)
        @size = size
      end

      def max = @size - 1

      def outsize?(x, y) = x == 0 || x == max || y == 0 || y == max

      def down_from(x, y)
        o = @obstacles[:columns][x].find { |y1| y1 > y }
        [x, o&.pred || max]
      end

      def up_from(x, y)
        o = @obstacles[:columns][x].reverse.find { |y1| y1 < y }
        [x, o&.succ || 0]
      end

      def left_from(x, y)
        o = @obstacles[:rows][y].reverse.find { |x1| x1 < x }
        [o&.succ || 0, y]
      end

      def right_from(x, y)
        o = @obstacles[:rows][y].find { |x1| x1 > x }
        [o&.pred || max, y]
      end

      private

      def prepare_obstacles(obstacles)
        columns = Hash.new { |h, k| h[k] = [] }
        rows = Hash.new { |h, k| h[k] = [] }

        obstacles.sort.each do |x, y|
          columns[x] << y
          rows[y] << x
        end

        {columns: columns, rows: rows}
      end
    end

    class Pathfinder
      def initialize(area:, guard:)
        @area = area
        @guard = guard
      end

      # Move the @guard until it either go outside the area or stuck in a loop.
      def move!
        loop do
          next_loc, next_dir = find_next_position
          return [:loop, @guard] if loop?([next_loc, @guard.direction])
          @guard.move_to(next_loc, next_dir)
          return [:outside, @guard] if outside?
        end
      end

      private

      def find_next_position
        case @guard.direction
        when :down  then [@area.down_from(*@guard.location),  :left]
        when :left  then [@area.left_from(*@guard.location),  :up]
        when :right then [@area.right_from(*@guard.location), :down]
        when :up    then [@area.up_from(*@guard.location),    :right]
        end
      end

      def loop?(pos) = @guard.path.include?(pos)
      def outside? = @area.outsize?(*@guard.location)
    end

    ##
    # Solving puzzle

    def self.part1(input)
      location, obstacles, size = parse(input)
      run(location, obstacles, size) => [:outside, guard]
      guard.visited.add(location).size
    end

    def self.part2(input)
      location, obstacles, size = parse(input)
      run(location, obstacles, size) => [:outside, guard]

      guard
        .visited
        .map { run(location, obstacles.dup.push(_1), size) }
        .filter { _1.first == :loop }
        .length
    end

    private

    def self.run(location, obstacles, size)
      guard = Guard.new(location)
      area = Area.new(size, obstacles)
      finder = Pathfinder.new(area: area, guard: guard)
      finder.move!
    end

    def self.parse(input)
      guard = nil
      obstacles = []
      xs = input.lines(chomp: true)

      (0...xs.length).each do |y|
        (0...xs.length).each do |x|
          case xs[y][x]
          when "^"
            guard = [x, y]
          when "#"
            obstacles << [x, y]
          end
        end
      end

      [guard, obstacles, xs.length]
    end
  end
end
