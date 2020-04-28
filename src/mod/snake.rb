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
    end

    def draw
      Square.new(x: @pos_x, y: @pos_y, size: @size, color: @color)
    end
  end
end
