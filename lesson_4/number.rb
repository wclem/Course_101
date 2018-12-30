numbers = [1, 2, 4, 5, 7, 8, 10, 13, 14]
odd_numbers = []
even_numbers = []

for number in numbers
  next if number.odd?
  even_numbers << number
end

for number in numbers
  next unless number.odd?
  odd_numbers << number
end

puts odd_numbers
puts even_numbers

puts '----------------'

numbers2 = [1, 2, 4, 5, 7, 8, 10, 13, 14]
odd_numbers2, even_numbers2 = numbers2.partition do |number|
    number.even?
end

puts odd_numbers2
puts even_numbers2