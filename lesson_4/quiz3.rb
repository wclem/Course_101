numbers = [7, 3, 5, 2, 1, 8, 4]
counter = 0

loop do
  number = numbers[counter]
  counter = 0

  loop do
    counter += 1
    puts counter

    break if counter >= number
  end

  counter += 1
  break if counter >= numbers.size
end