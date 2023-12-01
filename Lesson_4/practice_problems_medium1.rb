# q1
class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi
    greet('hello')
  end
end

class Goodbye < Greeting
  def bye
    greet "Goodbye"
  end
end


class KrispyKreme
  def initialize(filling, topping)
    @filling = filling.nil? ? 'Plain' : filling
    @topping = topping
  end

  def to_s
    return "#{@filling} with #{@topping}" unless @topping.nil?
    @filling
  end
end
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  # => "Plain"

puts donut2
  # => "Vanilla"
# 
puts donut3
  # => "Plain with sugar"

puts donut4
  # => "Plain with chocolate sprinkles"

puts donut5
  # => "Custard with icing"