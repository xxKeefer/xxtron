# frozen_string_literal: true

require_relative './src/mod/req.rb'
require_relative './src/mod/snake.rb'
set title: 'xxTron'

player = Snake::Player.new
player.draw
show # displays the window
