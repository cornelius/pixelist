require "io/wait"

class Snake < Worker
  def start
    @x = display.width / 2
    @y = display.height / 2
  end

  def step
    display.unset_pixel(x: @x, y: @y)

    if $stdin.ready?
      key = $stdin.getc
      puts "KEY: #{key}"
    end

    @x += 1

    display.set_pixel(x: @x, y: @y)

    true
  end
end
