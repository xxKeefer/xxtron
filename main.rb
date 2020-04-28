# frozen_string_literal: true

require_relative './src/mod/req.rb'
require_relative './src/mod/snake.rb'
set title: 'xxTron'
w = Window.width
h = Window.height
player = Snake::Player.new(w, h, w / 2, h / 2 - 5, 5, 'purple')
computer = Snake::Computer.new(w, h, w / 2, h / 2 + 5, 5, 'yellow')

update do
  on :key_down do |event|
    player.turn(event.key)
  end
  player.crash if player.detect_crash(computer.tail)
  player.update
  computer.crash if computer.detect_crash(player.tail)
  computer.avoid_collision(player.tail)
  computer.update
  # clear if player.crashed
  # player.info
  player.draw
  computer.draw
end
show # displays the window
