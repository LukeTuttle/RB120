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
    grid_cols.map {|arr| decrement_1(arr)}
  end

  def row_indexes(side_length)
    grid_rows = []
    (1..(side_length**2)).each_slice(side_length) {|row| grid_rows << row}
    grid_rows.map {|arr| decrement_1(arr)}
  end

  def diagonal_indexes(side_length)
    tl_br = (0...side_length).map { |row_i| (row_i * side_length) + (row_i + 1) }
    tr_bl = (0...side_length).map { |row_i| side_length + (2 * row_i) }
    [tl_br, tr_bl].map {|arr| decrement_1(arr)}
  end

  def decrement_1(arr)
    arr.map {|el| el - 1}
  end
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

  def update_token(token)
    @token = token
    update_shape(token)
  end

  def available?
    token.nil?
  end

  private

  attr_reader :shape

  def update_shape(token)
    shape[1] = token
  end
end

class Player
  attr_reader :name, :marker

  include Communicable
end

class Human < Player
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

class Computer < Player
  def initialize
    @name = 'Robo'
    @marker = 'O'
  end

  def choose_square(board)
    board.available_moves.sample
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

  def full?
    available_moves.empty?
  end

  def available_moves
    squares.filter_map.with_index { |sq, i| i if sq.token.nil? }
  end

  def winner?(token)
    all_sequences = [row_indexes(size), col_indexes(size), diagonal_indexes(size)]

    all_sequences.any? do |sequence_set_indexes|
      sequence_set_indexes.any? do |sequence_indexes|
        sequence = squares.values_at(*sequence_indexes).map(&:token)
        winning_sequence?(token, sequence)
      end
    end
  end

  def winning_sequence?(token, sequence)
    sequence.all? { |sq| sq == token }
  end

  private

  attr_accessor :squares
end

class TTTGame
  attr_reader :board, :human, :computer

  include Communicable

  def initialize(grid_row_length = 3)
    @board = Board.new(grid_row_length)
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    msg "Hello! Welcome to Tic-Tac-Toe!"
  end

  def first_player_moves
    msg "#{human.name} it's your turn, choose a square"
    choice = human.choose_square(board)
    board.update(human.marker, choice)
  end

  def second_player_moves
    choice = computer.choose_square(board)
    board.update(computer.marker, choice)
    msg "#{computer.name} chose square #{choice + 1}!"
    sleep 0.5
  end

  def someone_won?
    return human if board.winner?(human.marker) 
    return computer if board.winner?(computer.marker)
    false
  end

  def display_result
    board.display
    return msg "#{someone_won?.name} won!" unless board.full?
    msg "No winner! Board is full!"
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

      second_player_moves
      break if someone_won? || board.full?
    end
    display_result
    display_goodbye_message
  end
end

TTTGame.new.play
