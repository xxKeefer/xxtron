# frozen_string_literal: true

require_relative './src/mod/req.rb'
require_relative './src/mod/snake.rb'
set title: 'xxTron'

player = Snake::Player.new

update do
  on :key_down do |event|
    player.turn(event.key)
  end
  player.update
  # player.info
  player.draw
end
show # displays the window
