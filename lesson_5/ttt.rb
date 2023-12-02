require 'pry-byebug'

module Communicable
  def msg(str)
    puts '=> ' + str
  end
end

module GridIndexable
  def col_indexes(side_length)
    grid_cols = []
    col_index = 1

    until col_index > side_length
      col_indexes = []
      current_index = col_index
      until col_indexes.size == side_length
        col_indexes << current_index
        current_index += side_length
      end
      grid_cols << col_indexes
      col_index += 1
    end
    grid_cols
  end

  def row_indexes(side_length)
    grid_rows = []
    (1..(side_length**2)).each_slice(side_length) {|row| grid_rows << row}
    grid_rows
  end

  def diagonal_indexes(side_length)
    tl_br = (0...side_length).map { |row_i| (row_i * side_length) + (row_i + 1) }
    tr_bl = (0...side_length).map { |row_i| side_length + (2 * row_i) }
    [tl_br, tr_bl]
  end
end
      
      
    # for each col_i in (0...side_length)
    #   for each row_i in (0...side_length)
    #   square_i = (row_i * side_length) + (1 + col_i)

    # indexes = []
    # (0...side_length).each do |col_i|
    #   (0...side_length).map { |row_i| (row_i * board.size) +  1 }

  # PEDAC
  # method should return true or false
  # method will need to access state of collections of squares with a length of board size
  # collections will represent rows, collumns and diagonals
  # HOW TO BUILD ROWS COLS AND DIAGS
    # ROWS: each slice of length board size gives you each row
    # COLS: for each col `col_i` each square has an index equal to the product of the row index (start 0) and board size) + (1 + col_i)OR
          #  each square has an index equal to the prodcut of the row index (start 1) and board size) - (board size - 1)
    # DIAG:  
      # Top left - bottom right: (row index * board size ) + row index + 1 
      # each square has and index equal to the row index (start 1) * board size) - (board size - row index)
      # Top right- bottom left: board size + (2 * distance from first row i.e row index (start 0))

      # 1 0
      # 5 1
      # 9 2


  
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

  def update_token(token)
    @token = token
    update_shape(token)
  end

  def available?
    # binding.pry
    token.nil?
  end
  
  private
  
  attr_reader :shape
  
  def update_shape(token)
    shape[1] = token
  end
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
      choice = choice.to_i - 1 # correct for indexing at 0
      break if board.available_moves.include?(choice)
      msg "Input must be an unmarked square 1..#{board.size**2}"
    end
    choice
  end
end

class Board
  attr_accessor :size

  include GridIndexable

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
    squares[index].update_token(token)
  end

  # def valid_choice?(index)
  #   (0...(size**2)).include?(index) && squares[index].available?
  # end

  def full?
    available_moves.empty?
  end

  def available_moves
    squares.filter_map.with_index { |sq, i| i if sq.token.nil? }
  end

  private

  attr_accessor :squares
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

  def someone_won?
    false
  end

  def display_result
    msg "This is where I will display a result:  "
  end

  def display_goodbye_message
    msg "Thank you for playing. Goodbye!"
  end

  def play
    display_welcome_message
    loop do
      board.display
      first_player_moves
      break if someone_won? || board.full?

      # second_player_moves
      # break if someone_won? || board.full?
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