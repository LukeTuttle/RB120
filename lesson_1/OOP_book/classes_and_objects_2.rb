class Vehicle
  attr_accessor :color
  attr_reader :speed, :year, :model
  @@vehicle_count = 0
  
  
  def initialize(year, model, color)
    super()
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@vehicle_count += 1
  end
  
  def self.vehicle_count
    puts @@vehicle_count
  end
  
  def age
    puts "Your #{model} is #{calc_age} years old"
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
  
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end
  
  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
  
  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  private
  
  def calc_age
    Time.now.year - self.year
  end
  
end

module Towable
  def will_it_tow?(pounds)
    pounds < 2000
  end
end


class Truck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
  def to_s
    "My truck is a #{color}, #{year}, #{@model}!"
  end
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{color}, #{year}, #{@model}!"
  end
end


lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
puts MyCar.ancestors
puts Truck.ancestors
puts Vehicle.ancestors
puts '======'
lumina.age


class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    self.grade > other.grade
  end

  protected
  
  def grade
    @grade
  end
end

joe = Student.new('Joe', 90)
bob = Student.new('Bob', 85)

puts joe.better_grade_than?(bob)