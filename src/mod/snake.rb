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
        puts 'Turning: UP'
      when 'a'
        go_left
        puts 'Turning: LEFT'
      when 's'
        go_down
        puts 'Turning: DOWN'
      when 'd'
        go_right
        puts 'Turning: RIGHT'
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
      @color = 'red'
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

    def crash
      @crashed = true
      @color = 'gray'
    end

    def avoid_collision(other_tail)
      steer = %w[w a s d]
      steer.reject! { |dir| dir == 'w' } unless cango_up?(other_tail)
      steer.reject! { |dir| dir == 'a' } unless cango_left?(other_tail)
      steer.reject! { |dir| dir == 's' } unless cango_down?(other_tail)
      steer.reject! { |dir| dir == 'd' } unless cango_right?(other_tail)
      if on_edge?
        puts "Snake on EDGE! options: #{steer.inspect}"
        turn(steer.sample) if steer.length < 2
      elsif steer.length < 3
        turn(steer.sample)
      end
    end

    def cango_up?(other_tail)
      unless @pos_y - @speed < 0 || @tail.include?([@pos_x, @pos_y - @speed]) || other_tail.include?([@pos_x, @pos_y - @speed])
        true
      end
    end

    def cango_down?(other_tail)
      unless @pos_y + @speed > @map_hieght - @size || @tail.include?([@pos_x, @pos_y + @speed]) || other_tail.include?([@pos_x, @pos_y + @speed])
        true
      end
    end

    def cango_left?(other_tail)
      unless @pos_x - @speed < 0 || @tail.include?([@pos_x - @speed, @pos_y]) || other_tail.include?([@pos_x - @speed, @pos_y])
        true
      end
    end

    def cango_right?(other_tail)
      unless @pos_x + @speed > @map_width - @size || @tail.include?([@pos_x + @speed, @pos_y]) || other_tail.include?([@pos_x + @speed, @pos_y])
        true
      end
    end

    def on_edge?
      return true if onedge_up? || onedge_left? || onedge_down? || onedge_right?
    end

    def onedge_up?
      return true if @spd_y.zero? && @pos_y.zero?
    end

    def onedge_down?
      return true if @spd_y.zero? && @pos_y == @map_hieght - @size
    end

    def onedge_left?
      return true if @spd_x.zero? && @pos_x.zero?
    end

    def onedge_right?
      return true if @spd_x.zero? && @pos_x == @map_hieght - @size
    end
  end
end
