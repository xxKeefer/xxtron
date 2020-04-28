# frozen_string_literal: true

# This module contains functions and classes pertaining to the snake like
# objects in the game
module Snake
  require_relative 'req.rb'
  # this class is for player controlled entities
  class Player
    def initialize(pos_x = 10, pos_y = 10, size = 5, color = 'purple')
      @pos_x = pos_x
      @pos_y = pos_y
      @size = size
      @color = color
      @speed = @size
      @spd_x = 0
      @spd_y = 0
      @tail = []
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
      @pos_x += (@spd_x * @speed)
      @pos_y += (@spd_y * @speed)
    end

    def info
      puts "Position: [#{@pos_x},#{@pos_y}] Direction [#{@spd_x},#{@spd_y}]"
    end
  end
end
