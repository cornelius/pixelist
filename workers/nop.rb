class Nop < Worker
  def start
  end
  
  def step
    false
  end
end
