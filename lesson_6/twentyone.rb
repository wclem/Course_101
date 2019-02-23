# Twenty-One Program

SUITS = %w[H D S C] # Hearts, Diamonds, Spades, Clubs
FACES = %w[2 3 4 5 6 7 8 9 10 J K Q A]
TARGET_SCORE = 21
STAY_SCORE = 17

def welcome_message
  puts "Welcome to Twenty-One!"
  puts "You can hit or stay, but don't go over 21!"
  puts "Press return to hit, and 's' to stay."
  puts "It's your turn..."
end

def initialize_deck
  carddeck = []
  SUITS.each do |suit|
    FACES.each do |face|
      carddeck << [suit, face]
    end
  end
  carddeck
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i == 0 # J, Q, K
             10
           else
             value.to_i
           end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end
  sum
end

def deal_card(deck)
  card = deck.sample
  deck.delete(card)
  card
end

def busted?(hand)
  true if total(hand) > 21
end

def get_card_name(card)
  case card
  when "J"
    "Jack"
  when "Q"
    "Queen"
  when "K"
    "King"
  when "A"
    "Ace"
  else
    card
  end
end

def show_multiple_cards(hand)
  cardcount = hand.count
  msg = ''
  for i in 0..cardcount - 1
    msg += get_card_name(hand[i][1]).to_s
    if i == cardcount - 2
      msg += ", and "
    elsif i < cardcount - 2
      msg += ", "
    end
  end
  msg
end

def show_player_cards(hand)
  if hand.count == 2
    "You have: #{get_card_name(hand[0][1])} and " +
      get_card_name(hand[1][1]).to_s
  else
    "You have: " + show_multiple_cards(hand)
  end
end

def show_dealer_cards(hand)
  if hand.count == 2
    "Dealer has: #{get_card_name(hand[0][1])} and an unknown card"
  else
    "Dealer has: " + show_multiple_cards(hand)
  end
end

def decide_game_result(player_total, dealer_total)
  if player_total > 21
    0
  elsif dealer_total > 21
    1
  elsif player_total > dealer_total
    2
  elsif player_total == dealer_total
    3
  else
    4
  end
end

def display_game_result(game_result, player_total, dealer_total)
  case game_result
  when 0
    "You busted! Dealer wins!"
  when 1
    "Dealer busted, you win!"
  when 2
    "You won with #{player_total} to #{dealer_total} points! Congrats!"
  when 3
    "It's a tie"
  when 4
    "You plain lost with only #{player_total} to #{dealer_total} points..."
  end
end

def play_again?
  puts "Play again? (y/n)"
  gets.chomp == 'y'
end

# Start game

welcome_message

player_competition_score = 0
dealer_competition_score = 0

# Game loop
loop do
  # Initialize all local variables
  deck = initialize_deck
  answer = nil
  player_hand = []
  dealer_hand = []
  player_hand << deal_card(deck)
  dealer_hand << deal_card(deck)
  dealer_hand << deal_card(deck)

  # Player turn
  loop do
    player_hand << deal_card(deck)
    puts show_player_cards(player_hand)
    puts show_dealer_cards(dealer_hand)
    break if busted?(player_hand)
    puts "Hit or stay?"
    answer = gets.chomp
    break if answer == 's'
  end

  if busted?(player_hand)
    puts "You busted!"
  else
    # Dealer turn
    puts "Dealer's turn..."
    loop do
      puts show_dealer_cards(dealer_hand)
      dealer_total = total(dealer_hand)
      if dealer_total > TARGET_SCORE
        puts "Dealer busts!"
        break
      end
      if dealer_total >= STAY_SCORE
        puts "Dealer stays with #{dealer_total} points."
        break
      end
      dealer_hand << deal_card(deck)
    end
  end

  # Compare scores
  player_total = total(player_hand)
  dealer_total = total(dealer_hand)

  # Adjust competition totals
  if player_total > dealer_total
    player_competition_score += 1
  end
  if dealer_total > player_total
    dealer_competition_score += 1
  end

  puts display_game_result(decide_game_result(player_total, dealer_total),
                           player_total,
                           dealer_total)

  break if player_competition_score >= 5 || dealer_competition_score >= 5
  break unless play_again?
  system 'clear'
  system 'cls'
end

puts "Player got #{player_competition_score} points."
puts "Dealer got #{dealer_competition_score} points."
puts "Thanks for playing!"
