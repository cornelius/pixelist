# Langton's Ant (https://en.wikipedia.org/wiki/Langton%27s_ant)

class Ant < Worker
  def start
    display.enable_borders = false
    @x = display.width / 2
    @y = display.height / 2
    @direction = :north
  end

  def step
    state = display.pixel(x:@x, y:@y)
    if state
      turn_left
    else
      turn_right
    end
    display.set_pixel(x:@x, y:@y, state:!state)
    move

    true
  end

  def turn_left
    case @direction
    when :north
      @direction = :west
    when :south
      @direction = :east
    when :west
      @direction = :south
    when :east
      @direction = :north
    else
      raise "Invalid direction '#{@direction}'"
    end
  end

  def turn_right
    case @direction
    when :north
      @direction = :east
    when :south
      @direction = :west
    when :west
      @direction = :north
    when :east
      @direction = :south
    else
      raise "Invalid direction '#{@direction}'"
    end
  end

  def move
    case @direction
    when :north
      @y -= 1
    when :south
      @y += 1
    when :west
      @x -= 1
    when :east
      @x += 1
    else
      raise "Invalid direction '#{@direction}'"
    end
  end
end
