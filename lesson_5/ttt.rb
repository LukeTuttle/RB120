require 'pry-byebug'

module Communicable
  def msg(str)
    puts '=> ' + str
  end
end

class Board
  attr_accessor :size

  def initialize(grid_n = 3)
    @size = grid_n
    @squares = (grid_n**2).times.with_object([]) { |i, obj| obj << Square.new((i + 1), size) }
  end

  def display
    squares.each_slice(size) { |row| draw_row(row) }
  end

  def draw_row(subarr)
    puts subarr.map(&:to_s).join
  end

  def update(token, index)
    squares[index - 1].update_shape(token)
  end

  def valid_choice?(index)
    (1..(size**2)).include?(index)
  end

  private

  attr_accessor :squares
end

class Square
  attr_reader :index, :token

  def initialize(index, grid_side_length)
    @index = index
    @shape = create_shape(index, grid_side_length)
    @token = nil
  end

  def create_shape(index, grid_side_length)
    if index > ((grid_side_length**2) - grid_side_length) # if in last row
      index == grid_side_length**2 ? "   " : "   |" # bottom right square equals sidelength**2
    elsif (index % grid_side_length) == 0
      "___"
    else
      "___|"
    end
  end

  def to_s
    shape.clone
  end

  def update_shape(token)
    shape[1] = token
  end

  private

  attr_reader :shape
end

class Player
  attr_reader :name

  include Communicable

  def initialize
  end

  def mark
  end
end

class Human < Player
  attr_reader :marker
  def initialize
    @name = "User"
    @marker = 'X'
  end

  def choose_square(board)
    choice = nil
    loop do
      choice = gets.chomp
      break if board.valid_choice?(choice.to_i)
      msg "Input must be an interger 1..#{board.size**2}"
    end
    choice.to_i
  end
end


class TTTGame
  attr_reader :board, :human, :computer

  include Communicable

  def initialize
    @board = Board.new
    @human = Human.new
    # @computer = Computer.new
  end

  def display_welcome_message
    msg "Hello! Welcome to Tic-Tac-Toe!"
  end

  def first_player_moves
    msg "#{human.name} it's your turn, choose a square"
    board.update(human.marker, human.choose_square(board))
  end

  def play
    display_welcome_message
    loop do
      board.display
      first_player_moves
      board.display
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end



# my_board = Board.new(3)
# my_board.squares[0].update_shape('X')
# my_board.display
game = TTTGame.new
game.play