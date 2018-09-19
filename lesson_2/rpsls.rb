# RPS with bonus options
# William Clemens, Lesson 2
# 2018-09-15

GAME_WINNING_SCORE = 5
WINNING_CHOICES = {
  'rock' =>     ['scissors', 'lizard'],
  'scissors' => ['paper', 'lizard'],
  'paper' =>    ['rock', 'spock'],
  'spock' =>    ['rock', 'scissors'],
  'lizard' =>   ['paper', 'spock']
}

VALID_CHOICES = %w(rock paper scissors lizard spock)

def display_current_score(p, c)
  puts "Player: #{p}  Computer: #{c}"
end

def win?(first, second)
  WINNING_CHOICES[first].include?(second)
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_welcome_message

  system('clear') || system('cls')
  prompt("Welcome to Rock-Paper-Scissors-Lizard-Spock!")
  prompt("You will play against the computer.")
  prompt("You win if you get to 5 points first!")
  prompt("Get ready....")
end

display_welcome_message

player_score = 0
computer_score = 0

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp().downcase()

    case choice
    when 'r'
      choice = 'rock'
    when 'p'
      choice = 'paper'
    when 's'
      choice = 'scissors'
    when 'l'
      choice = 'lizard'
    when 'sp'
      choice = 'spock'
    end

    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  if win?(choice, computer_choice)
    prompt("You won!")
    player_score += 1
  elsif win?(computer_choice, choice)
    prompt("Computer won!")
    computer_score += 1
  else
    prompt("It's a tie!")
  end

  display_current_score(player_score, computer_score)

  if player_score == GAME_WINNING_SCORE || computer_score == GAME_WINNING_SCORE
    if player_score == GAME_WINNING_SCORE
      prompt("You won the game, congratulations!")
    else
      prompt("The computer beat you!")
    end

    prompt("Do you want to play again?")
    answer = Kernel.gets().chomp()
    break unless answer.downcase().start_with?('y')
    player_score = 0
    computer_score = 0
    system('clear') || system('cls')
  end
end

prompt("Thank you for playing. Good bye!")
