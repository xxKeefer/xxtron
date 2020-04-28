# frozen_string_literal: true

# This module contains functions and classes pertaining to the snake like
# objects in the game
module Snake
  require_relative 'req.rb'
  # this class is for player controlled entities
  class Player
    def initialize
      @size = 5
      @position = 10
      @color = 'purple'
    end
  end
end
