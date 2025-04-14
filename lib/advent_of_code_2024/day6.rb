# frozen_string_literal: true

module AdventOfCode2024
  # Day6: Guard Gallivant
  module Day6
    class Guard
      attr_reader :direction, :location, :path

      def initialize(location, direction = :up)
        @location = location
        @direction = direction
        @path = Set.new
      end

      def move_to(loc, dir, path)
        @location = loc
        @direction = dir
        @path.add?(path)
      end

      def visited
        # Expand path sections
        @path.flat_map do |dir, xs, ys|
          case dir
          when :up
            (ys[0]).downto(ys[1]).map { |y| [xs, y] }
          when :down
            (ys[0]).upto(ys[1]).map { |y| [xs, y] }
          when :left
            (xs[0]).downto(xs[1]).map { |x| [x, ys] }
          when :right
            (xs[0]).upto(xs[1]).map { |x| [x, ys] }
          end
        end.to_set
      end

      def loop?(path) = @path.include?(path)
    end

    class Area
      def initialize(size, obstacles)
        @obstacles = obstacles
        @size = size
      end

      def max = @size - 1

      def outsize?(x, y) = x == 0 || x == max || y == 0 || y == max

      def down_from(x, y)
        o = @obstacles[:columns][x].find { |y1| y1 > y }
        [x, o&.pred || max]
      end

      def up_from(x, y)
        o = @obstacles[:columns][x].filter { |y1| y1 < y }.last
        [x, o&.succ || 0]
      end

      def left_from(x, y)
        o = @obstacles[:rows][y].filter { |x1| x1 < x }.last
        [o&.succ || 0, y]
      end

      def right_from(x, y)
        o = @obstacles[:rows][y].find { |x1| x1 > x }
        [o&.pred || max, y]
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
          path = to_guard_path(*next_loc)
          return [:loop, @guard] if @guard.loop?(path)
          @guard.move_to(next_loc, next_dir, path)
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

      def to_guard_path(nx, ny)
        x, y = @guard.location

        case @guard.direction
        when :up    then [:up, x, [y.pred, ny]]
        when :down  then [:down, x, [y.succ, ny]]
        when :left  then [:left, [x.pred, nx], y]
        when :right then [:right, [x.succ, nx], y]
        end
      end

      def outside? = @area.outsize?(*@guard.location)
    end

    ##
    # Solving puzzle

    def self.part1(input)
      location, obs, size = parse(input)
      run(location, prepare_obstacles(obs), size) => [:outside, guard]
      guard.visited.add(location).size
    end

    def self.part2(input)
      location, obs, size = parse(input)
      obstacles = prepare_obstacles(obs)
      run(location, obstacles, size) => [:outside, guard]

      guard
        .visited
        .map do |loc|
          # HACK: Don't recalculate obstacles hash each time. Just add new
          # obsacle to hash and then remove it (because mutability sucks!).
          add_obstacle(obstacles, loc)
          res = run(location, obstacles, size)
          remove_obstacle(obstacles, loc)
          res
        end
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

    def self.add_obstacle(obs, loc)
      x, y = loc
      ys = obs[:columns][x].add(y)
      obs[:columns][x] = ys.sort.to_set
      xs = obs[:rows][y].add(x)
      obs[:rows][y] = xs.sort.to_set
      obs
    end

    def self.remove_obstacle(obs, loc)
      x, y = loc
      obs[:columns][x].delete(y)
      obs[:rows][y].delete(x)
      obs
    end

    def self.prepare_obstacles(obstacles)
      columns = Hash.new { |h, k| h[k] = Set.new }
      rows = Hash.new { |h, k| h[k] = Set.new }

      obstacles.sort.each do |x, y|
        columns[x].add(y)
        rows[y].add(x)
      end

      {columns: columns, rows: rows}
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
