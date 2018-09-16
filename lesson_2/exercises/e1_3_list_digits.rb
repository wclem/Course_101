# Return list of digits in the number
def digit_list(number)
  number_string = number.to_s
  num_array = []
  number_string.each_char { |x| num_array << x.to_i }
  num_array

end





puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true
