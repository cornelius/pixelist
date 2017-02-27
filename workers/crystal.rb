class Crystal < Worker
  def start
    @x, @y = random_position
    display.set_pixel(x:@x, y:@y)

    display.enable_borders = false
  end

  def step
    if has_direct_neighbours(x:@x, y:@y)
      @x, @y = random_position
      display.set_pixel(x:@x, y:@y)
    else
      display.unset_pixel(x:@x, y:@y)
      random_step
      display.set_pixel(x:@x, y:@y)
    end
  end

  def random_position
    return rand(display.width), rand(display.height)
  end

  def random_step
    @x += rand(3) - 1
    @y += rand(3) - 1
  end

  def has_direct_neighbours(x:, y:)
    display.pixel(x:x-1, y:y) || display.pixel(x:x+1, y:y) ||
      display.pixel(x:x, y:y-1) || display.pixel(x:x, y:y+1)
  end
end
