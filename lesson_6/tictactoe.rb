# require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
EMPTY_SPACE = ' '
GO_FIRST = 'computer' # 'player' || 'computer' || 'choose'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  #system 'clear'
  #system 'cls'
  puts "You: #{PLAYER_MARKER}   Computer: #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(join_items, delim = ', ', conjunction = 'or')
  out_string = ''
  if join_items.length == 2 
    out_string = join_items[0].to_s + EMPTY_SPACE + conjunction + EMPTY_SPACE + join_items[1].to_s
  elsif join_items.length > 2
    last_item = join_items.pop
    join_items.each { |x| out_string << x.to_s + delim }
    out_string << conjunction + EMPTY_SPACE + last_item.to_s
  else
    join_items[0].to_s
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  opportunity_move = detect_opportunity(brd)
  threat_move = detect_threat(brd)
  if !opportunity_move.nil?
    prompt "Computer: Offensive move!"
    brd[opportunity_move] = COMPUTER_MARKER
    return
  elsif !threat_move.nil?
    prompt "Computer: Defensive move!"
    brd[threat_move] = COMPUTER_MARKER
    return
  elsif brd[5] == INITIAL_MARKER
    prompt "Computer: Take 5"
    brd[5] = COMPUTER_MARKER
    return 
  else
    prompt "Computer: Random move!"
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_threat(brd) # This is the Defensive AI
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      blocking_index = brd.values_at(*line).index(INITIAL_MARKER)
      if blocking_index.nil?
        next
      else
        puts "Threat found: #{line} at space #{line[blocking_index]}"
        return line[blocking_index]
      end
    end
  end
  nil # Return nil instead of the entire WINNING_LINES array, to show no defensive move found
end

def detect_opportunity(brd) # This is the Offensive AI
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      blocking_index = brd.values_at(*line).index(INITIAL_MARKER)
      if blocking_index.nil?
        next
      else
        puts "Opportunity found: #{line} at space #{line[blocking_index]}"
        return line[blocking_index]
      end
    end
  end
  nil # Return nil instead of the entire WINNING_LINES array, to show no opportunity move found
end

def choose_player
  'player'
end

# Player/Computer score variables
player_score = 0
computer_score = 0

# Start game loop
loop do
  board = initialize_board
  puts "Starting game"

  if GO_FIRST == 'choose'
    first_player = choose_player
  elsif GO_FIRST == 'player'
    first_player = 'player'
  else
    first_player = 'computer'
  end
  
  if first_player == 'player' then player_order = ['player', 'computer']
  else player_order = ['computer', 'player']
  end 

  #display_board(board)

  loop do
    
    display_board(board)
    # Publish scores
    puts "Player: #{player_score}"
    puts "Computer: #{computer_score}"

    player_order.each do | plyr | 
      if plyr == 'player'
        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
      else
        computer_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
      end
      #display_board(board)
      
    end
    break if someone_won?(board) || board_full?(board)
  
    #player_places_piece!(board)
    #break if someone_won?(board) || board_full?(board)

    #computer_places_piece!(board)
    #break if someone_won?(board) || board_full?(board)
  end

  display_board(board)
  # Publish scores
  puts "Player: #{player_score}"
  puts "Computer: #{computer_score}"
  
  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  # Update scores
  player_score += 1 if detect_winner(board) == 'Player'
  computer_score += 1 if detect_winner(board) == 'Computer'

  # Check for score of 5
  if player_score == 5
    puts "Player wins the tournament!"
  elsif computer_score == 5
    puts "Computer wins the tournament!"
  end
  
  if player_score == 5 || computer_score == 5
    player_score = 0
    computer_score = 0
    prompt "Play again? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end

prompt "Thanks for playing the game!"
