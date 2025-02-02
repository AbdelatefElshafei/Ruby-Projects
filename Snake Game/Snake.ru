require 'ruby2d'

set background: 'navy'
set fps_cap: 20

GRID_SIZE = 20
GRID_WIDTH = (Window.width / GRID_SIZE).to_i
GRID_HEIGHT = (Window.height / GRID_SIZE).to_i

class Snake
  attr_accessor :direction

  def initialize
    mid_x = GRID_WIDTH / 2
    mid_y = GRID_HEIGHT / 2
    @positions = [[mid_x, mid_y - 2], [mid_x, mid_y - 1], [mid_x, mid_y], [mid_x, mid_y + 1]]
    @direction = 'down'
    @growing = false
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'white')
    end
  end

  def move
    return if @growing && @positions.length < 4 # Prevent moving when growing initially

    @positions.shift unless @growing
    @growing = false

    new_head = case @direction
               when 'down' then [head[0], head[1] + 1]
               when 'up' then [head[0], head[1] - 1]
               when 'right' then [head[0] + 1, head[1]]
               when 'left' then [head[0] - 1, head[1]]
               end

    @positions.push(new_coords(new_head[0], new_head[1]))
  end

  def can_change_direction_to?(new_direction)
    opposite_directions = { 'up' => 'down', 'down' => 'up', 'left' => 'right', 'right' => 'left' }
    new_direction != opposite_directions[@direction]
  end

  def x
    head[0]
  end

  def y
    head[1]
  end

  def grow
    @growing = true
  end

  def hit_itself?
    @positions.uniq.length != @positions.length
  end

  private

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end
end

class Game
  def initialize
    @score = 0
    place_new_ball
    @finished = false
  end

  def draw
    Square.new(x: @ball_x * GRID_SIZE, y: @ball_y * GRID_SIZE, size: GRID_SIZE, color: 'yellow')
    Text.new(text_message, color: finished? ? "red" : "green", x: 10, y: 10, size: 25)
  end

  def snake_hit_ball?(x, y)
    @ball_x == x && @ball_y == y
  end

  def record_hit
    @score += 1
    place_new_ball
  end

  def finish
    @finished = true
  end

  def finished?
    @finished
  end

  private

  def text_message
    if finished?
      "Game over! Your Score: #{@score}. Press 'R' to restart."
    else
      "Score: #{@score}"
    end
  end

  def place_new_ball
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
  end
end

snake = Snake.new
game = Game.new

update do
  clear
  game.draw

  unless game.finished?
    snake.move
    snake.draw

    if game.snake_hit_ball?(snake.x, snake.y)
      game.record_hit
      snake.grow
    end

    game.finish if snake.hit_itself?
  end
end

on :key_down do |event|
  if ['down', 'right', 'up', 'left'].include?(event.key)
    if snake.can_change_direction_to?(event.key)
      snake.direction = event.key
    end
  end

  if game.finished? && event.key == 'r'
    snake = Snake.new
    game = Game.new
  end
end

show
