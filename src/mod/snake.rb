# frozen_string_literal: true

# This module contains functions and classes pertaining to the snake like
# objects in the game
module Snake
  require_relative 'req.rb'
  # this class is for player controlled entities
  class Player
    attr_reader :crashed, :tail
    def initialize(map_width, map_hieght, pos_x = 10, pos_y = 10, size = 5, color = 'purple')
      @pos_x = pos_x
      @pos_y = pos_y
      @size = size
      @color = color
      @speed = @size
      @spd_x = 1
      @spd_y = 0
      @tail = []
      @crashed = false
      @map_width = map_width
      @map_hieght = map_hieght
    end

    def draw
      Square.new(x: @pos_x, y: @pos_y, size: @size, color: @color)
    end

    def turn(dir)
      case dir
      when 'w'
        go_up
      when 'a'
        go_left
      when 's'
        go_down
      when 'd'
        go_right
      end
    end

    def go_up
      return if @spd_y == 1

      @spd_y = -1
      @spd_x = 0
    end

    def go_left
      return if @spd_x == 1

      @spd_y = 0
      @spd_x = -1
    end

    def go_down
      return if @spd_y == -1

      @spd_y = 1
      @spd_x = 0
    end

    def go_right
      return if @spd_x == -1

      @spd_y = 0
      @spd_x = 1
    end

    def update
      crash if detect_crash
      @tail.push([@pos_x, @pos_y])
      @pos_x += (@spd_x * @speed)
      @pos_y += (@spd_y * @speed)
    end

    def detect_crash(other_tail = [])
      # hit a tail
      if @tail.detect { |e| @tail.count(e) > 1 || other_tail.include?(e) }
        return true
      end
      # snake outside lower bounds
      return true if @pos_x.negative? || @pos_y.negative?
      # snake outside upper bounds
      return true if @pos_x > @map_width || @pos_y > @map_hieght
    end

    def crash
      @crashed = true
    end

    def info
      puts "#{self.class.to_s.upcase} | Crashed? #{@crashed}" \
      " Position: [#{@pos_x},#{@pos_y}]" \
      " Direction [#{@spd_x},#{@spd_y}]"
    end
  end
  # this is the ai controlled snake
  class Computer < Player
    def initialize(map_width, map_hieght, pos_x = 10, pos_y = 20, size = 5, color = 'yellow')
      super
    end

    def look_around(other_tail); end
  end
end
