
class Card
  attr_reader :rank, :suit

  include Comparable

  CARD_VALUES = {
                 "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, "7"=>7, "8"=>8, "9"=>9,
                 "10"=>10, "Jack"=>11, "King"=>12, "Queen"=>13, "Ace"=>14
                }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_obj)
    return nil if other_obj.class != Card
    return 0 if rank == other_obj.rank
    return -1 if self < other_obj
    return 1 if self > other_obj
  end

  def <(other_obj)
    CARD_VALUES[rank.to_s] < CARD_VALUES[other_obj.rank.to_s]
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.