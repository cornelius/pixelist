class Display
  attr_reader :matrix, :width, :height, :filename
  attr_accessor :enable_borders, :keep_frames

  def initialize
    @matrix = ""
    @widht = 0
    @height = 0
    @enable_borders = true
    @keep_frames = false
    @frame_count = 1
  end

  def init(width:, height:)
    height.times do
      width.times do
        @matrix += "0"
      end
      @matrix += "\n"
    end

    @width = width
    @height = height

    self
  end

  def set(matrix)
    @matrix, @width, @height = normalize_matrix(matrix)
  end

  def set_pixel(x:, y:, state: true)
    if enable_borders
      if x >= @width
        raise PixelistError, "x index out of range, got #{x}, width #{@width}"
      end

      if y >= @height
        raise PixelistError, "y index out of range, got #{y}, height #{@height}"
      end
    else
      x = x % width
      y = y % height
    end

    @matrix[ y * (width + 1) + x ] = state ? "1" : "0"
  end

  def unset_pixel(x:, y:)
    set_pixel(x:x, y:y, state:false)
  end

  def pixel(x:, y:)
    if enable_borders
      if x >= @width || x < 0
        raise PixelistError, "x index out of range, got #{x}, width #{@width}"
      end

      if y >= @height || y < 0
        raise PixelistError, "y index out of range, got #{y}, height #{@height}"
      end
    else
      x = x % width
      y = y % height
    end

    return @matrix[ y * (width + 1) + x ] != "0"
  end

  def normalize_matrix(input_matrix)
    output_matrix = ""
    width = 0
    height = 0
    line_width = 0
    last_char_is_newline = false
    input_matrix.each_char do |char|
      if char == "." || char == "0"
        output_matrix += "0"
        line_width += 1
        last_char_is_newline = false
      elsif char == "\n"
        output_matrix += "\n"
        if line_width > width
          width = line_width
        end
        line_width = 0
        height += 1
        last_char_is_newline = true
      else
        output_matrix += "1"
        line_width += 1
        last_char_is_newline = false
      end
    end
    if line_width > width
      width = line_width
    end
    if !last_char_is_newline
      height += 1
    end
    return output_matrix, width, height
  end

  def load(filename)
    @filename = filename
    @matrix, @width, @height = normalize_matrix(File.read(filename))
  end

  def save(filename = nil)
    if filename
      @filename = filename
    end
    if @filename
      if keep_frames
        effective_path = File.join(File.dirname(@filename),File.basename(@filename, ".pixels") + "-" + sprintf("%03d", @frame_count) + ".pixels")
        @frame_count += 1
      else
        effective_path = @filename
      end
      File.write(effective_path, @matrix)
    end
  end

  def clear
    for i in 0..@matrix.length-1
      if @matrix[i] != "\n"
        @matrix[i] = "0"
      end
    end
  end

  def show
    puts "+" + "-" * @width + "+"
    format_matrix(@matrix).each_line do |line|
      puts "|" + line.chomp + "|"
    end
    puts "+" + "-" * @width + "+"
  end

  def format_matrix(input_matrix)
    output_matrix = ""
    input_matrix.each_char do |char|
      if char == "0"
        output_matrix += " "
      elsif char == "\n"
        output_matrix += "\n"
      else
        output_matrix += "O"
      end
    end
    output_matrix
  end
end
