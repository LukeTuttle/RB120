class Person
  # attr_accessor :name

  def name=(name)
    split_name = name.split
    @first_name = split_name.first
    @last_name = split_name.last
  end

  def name
    @first_name + ' ' + @last_name
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name