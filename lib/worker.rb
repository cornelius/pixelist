class Worker
  attr_reader :step_count, :display

  def initialize(display)
    @display = display
    @step_count = 0
  end

  def run(count: nil, show: false, sleep: nil)
    @step_count = 0
    start
    if count
      count.times do
        return if !do_run(show, sleep)
      end
    else
      loop do
        return if !do_run(show, sleep)
      end
    end
  end

  def do_run(show, sleep)
    @step_count += 1
    result = step
    @display.save
    if (show)
      system("clear")
      puts "Pixelist #{self.class.name} (step #{step_count})"
      @display.show
    end
    if sleep
      Kernel.sleep(sleep)
    end
    result
  end
end
