class CliController
  def initialize(pixels_file = nil)
    @pixels_file = pixels_file
  end

  def init(args)
    if args.count == 1
      width = args[0].to_i
      height = args[0].to_i
    elsif args.count == 2
      width = args[0].to_i
      height = args[1].to_i
    else
      width = 4
      height = 4
    end

    display = Display.new
    display.init(width: width, height: height)
    display.save(@pixels_file)

    puts "Created pixel file at '#{@pixels_file}'"
  end

  def show
    display = Display.new
    display.load(@pixels_file)
    display.show
  end

  def set(args)
    x = args[0].to_i
    y = args[1].to_i

    display = Display.new
    display.load(@pixels_file)
    display.set_pixel(x: x, y: y)
    display.save
  end

  def work(worker_name, show: false, sleep: 0.1)
    display = Display.new
    display.load(@pixels_file)

    require_relative "../workers/#{worker_name}"

    Module.const_get(filename_to_classname(worker_name)).new(display).run(show: show, sleep: sleep)
  end

  def filename_to_classname(filename)
    filename.split("_").map { |n| n.capitalize }.join
  end
end
