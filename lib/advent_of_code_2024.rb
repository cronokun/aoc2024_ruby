# frozen_string_literal: true

require_relative "advent_of_code_2024/version"

Dir["advent_of_code_2024/day*.rb", base: "lib"].each do |f|
  require_relative f.delete_suffix(".rb")
end

module AdventOfCode2024
  class Error < StandardError; end
end
