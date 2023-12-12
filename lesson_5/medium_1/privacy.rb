class Machine
  # attr_reader :switch
  def initialize(switch)
    @switch = switch
  end
  
  def switch_status
    puts "the switch is currently #{switch}"
  end

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  private

  attr_writer :switch

  attr_reader :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

a = Machine.new(:on)
a.switch_status
a.stop
a.switch_status
a.switch