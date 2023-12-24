class GuessingGame
  attr_reader :guesses_remaining, :low, :high
  def initialize(low, high)
    @guesses_remaining = Math.log2((high-low)).to_i + 1
    @secret_number = rand(low..high)
    @low = low
    @high = high
  end

  def play
    while @guesses_remaining > 0 do
      print_guesses_remaining
      player_guess = ask_for_guess
      print_response_to_guess(player_guess)
      break if player_guess == secret_number
      @guesses_remaining -= 1
    end

    if guesses_remaining > 0
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def print_guesses_remaining
    puts "You have #{guesses_remaining} guesses remaining"
  end

  def ask_for_guess
    player_guess = nil
    loop do
      puts "Enter a number between #{low} and #{high}:"
      player_guess = gets.chomp
      break if (low..high).include?(player_guess.to_i)
      puts "Invalid guess. Enter a number between #{low} and #{high}"
    end
    player_guess.to_i
  end

  def print_response_to_guess(player_guess)
    if player_guess < secret_number
      puts "Your guess is to low."
    elsif player_guess > secret_number
      puts "Your guess is to high."
    elsif player_guess == secret_number
      puts "That's the number!"
    else
      puts "Error in print response to guest method!"
    end
    puts ''
  end

  private

  attr_reader :secret_number
  
end

GuessingGame.new(501, 1500).play