module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
   return @fuel_capacity * @fuel_efficiency
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Watercraft
  attr_reader :propeller_count, :hull_count

  include Moveable
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    # ... other code to track catamaran-specific data omitted ...
  end

  def range
    super + 10
  end
end

class Catamaran
    # ... other code to track catamaran-specific data omitted ...
end

class Motorboat
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1,1,km_traveled_per_liter, liters_of_fuel_capacity)
  end
end