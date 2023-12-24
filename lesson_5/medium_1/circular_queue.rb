=begin
need to be able track indexes as ordered from oldes to most recently assigned
need a data structure to hold the objects in the que

when adding an element, it gets added to the right of whatever element was most recently added
When removing an element, the oldest element is removed


when all positions are empty, index 0 get used first
index 0 is now the oldest and most recently assigned index

could use an @index_tenure to keep track of indexes relative ages
when we choose to remove an object from the que, access index tenure and save the object from que at that index
  then replace the object at that index with nil and return the saved ('elelted) object
  dont forget to remove the index from index_tenure. 
  attempts to remove an object from an empty que should return nil
when adding an object, append the object to the que if the que size is less than 3
  if que is full, remove the oldest object and put the new object in its place. 

=end





class CircularQueue
  def initialize(size)
    @que = Array.new(size)
    @index_tenure = []
  end

  def enqueue(obj)
    if @que.all?(nil)
      @que[0] = obj
      @index_tenure << 0
    elsif @que.any?(nil)
      index_next_in_que = (@index_tenure.last + 1) % @que.size
      @que[index_next_in_que] = obj
      @index_tenure << index_next_in_que
    elsif @que.none?(nil)
      index_to_put_at_back_of_que = @index_tenure.first
      dequeue(obj)
      @index_tenure << index_to_put_at_back_of_que
    else
      puts "ERROR in enqueue method"
    end

    nil
  end

  def dequeue(replacement = nil)
    return nil if @que.all?(nil)

    index_of_oldest = @index_tenure.shift
    obj_for_returning = @que[index_of_oldest]
    @que[index_of_oldest] = replacement

    obj_for_returning
  end

  private
  attr_accessor :que
end


require 'pry-byebug'
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
# binding.pry
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil