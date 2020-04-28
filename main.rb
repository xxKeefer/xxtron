# frozen_string_literal: true

require_relative './src/mod/req.rb'
require_relative './src/mod/snake.rb'
set title: 'xxTron'

player = Snake::Player.new(Window.width, Window.height)

update do
  on :key_down do |event|
    player.turn(event.key)
  end
  player.update
  clear if player.crashed
  # player.info
  player.draw
end
show # displays the window
