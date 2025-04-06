# Copy-paste from https://raw.githubusercontent.com/minitest/minitest/refs/heads/master/lib/minitest/pride_plugin.rb.

require "minitest"

module Minitest
  def self.plugin_color_options opts, _options # :nodoc:
    opts.on "-c", "--color", "Show color output" do
      ColorIO.color!
    end
  end

  def self.plugin_color_init options # :nodoc:
    return unless ColorIO.color?

    io = ColorIO.new options[:io]

    self.reporter.reporters.grep(Minitest::Reporter).each do |rep|
      rep.io = io if rep.io.tty?
    end
  end

  class ColorIO
    # Activate the color plugin.

    def self.color!
      @color = true
    end

    def self.color?
      @color ||= false
    end

    # Start an escape sequence
    ESC = "\e["

    # End the escape sequence
    NND = "#{ESC}0m"

    # The IO we're going to pipe through.
    attr_reader :io

    def initialize io # :nodoc:
      @io = io
      # stolen from /System/Library/Perl/5.10.0/Term/ANSIColor.pm
      # also reference https://en.wikipedia.org/wiki/ANSI_escape_code
      @colors ||= (31..36).to_a
      @size   = @colors.size
      @index  = 0
    end

    # Wrap print to colorize the output.

    def print o
      case o
      when "." then
        io.print "#{ESC}32m#{o}#{NND}"
      when "S" then
        io.print "#{ESC}33m#{o}#{NND}"
      when "E", "F" then
        io.print "#{ESC}31m#{o}#{NND}"
      else
        io.print o
      end
    end

    def puts *o # :nodoc:
      o.map! do |s|
        if m = s.match(/\d+ runs, \d+ assertions, (?<failures>\d+) failures, (?<errors>\d+) errors, (?<skips>\d+) skips/)
          format_totals(s, m)
        elsif m = s.match(/Failure:/)
          format_failure(s)
        else
          s
        end
      end

      io.puts(*o)
    end

    def method_missing msg, *args # :nodoc:
      io.send(msg, *args)
    end

    private

    def format_failure(s)
      # s.sub(/Expected: (.+)$/, "Expected: #{ESC}32m\\1#{NND}")
      # s.sub(/  Actual: (.+)$/, "  Actual: #{ESC}31m\\1#{NND}")
      s
    end

    def format_totals(s, m)
      case
      when m["errors"] != "0" || m["failures"] != "0"
        s.sub(m[0], "#{ESC}31m#{m[0]}#{NND}")
      when m["skips"] != "0"
        s.sub(m[0], "#{ESC}33m#{m[0]}#{NND}")
      else
        s.sub(m[0], "#{ESC}32m#{m[0]}#{NND}")
      end
    end
  end
end
