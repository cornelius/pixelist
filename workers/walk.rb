class Walk < Worker
  def start
    @x = rand(display.width)
    @y = rand(display.height)

    @delta_x = 1
    @delta_y = 1
  end

  def step
    display.clear

    @x += @delta_x
    @y += @delta_y

    if @x >= display.width
      @x -= 1
      @delta_x = -1
    end
    if @y >= display.height
      @y -= 1
      @delta_y = -1
    end

    if @x < 0
      @x = 0
      @delta_x = 1
    end
    if @y < 0
      @y = 0
      @delta_y = 1
    end

    display.set_pixel(x: @x, y: @y)

    true
  end
end
