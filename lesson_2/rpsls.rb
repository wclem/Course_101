# RPS with bonus options
# William Clemens, Lesson 2
# 2018-09-15

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

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
    return 1
  elsif win?(computer, player)
    prompt("Computer won!")
    return 2
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

player_score = 0
computer_score = 0

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

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

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  winner = display_results(choice, computer_choice)

  if winner == 1
    player_score += 1
  elsif winner == 2
    computer_score += 1
  end

  display_current_score(player_score, computer_score)

  # reset if score = 5

  if player_score == 5 || computer_score == 5
    if player_score == 5
      prompt("You won the game, congratulations!")
    else
      prompt("The computer beat you!")
    end

    prompt("Do you want to play again?")
    answer = Kernel.gets().chomp()
    break unless answer.downcase().start_with?('y')
    player_score = 0
    computer_score = 0
  end
end

prompt("Thank you for playing. Good bye!")
