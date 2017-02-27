# Conway's Game of Life (https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

class Life < Worker
  def start
    display.enable_borders = false
  end

  def step
    new_display = Display.new
    new_display.init(width: display.width, height: display.height)

    for x in 0..display.width-1
      for y in 0..display.height-1
        neighbours = count_neighbours(x:x, y:y)
        if display.pixel(x: x, y:y)
          if neighbours < 2 || neighbours > 3
            new_state = false
          else
            new_state = true
          end
        else
          if neighbours == 3
            new_state = true
          else
            new_state = false
          end
        end
       new_display.set_pixel(x:x, y:y, state: new_state)
      end
    end

    display.set(new_display.matrix)

    true
  end

  def count_neighbours(x:, y:)
    count = 0
    for xx in x-1..x+1
      for yy in y-1..y+1
        next if xx == x && yy == y
        if display.pixel(x:xx, y:yy)
          count += 1
        end
      end
    end
    count
  end
end
