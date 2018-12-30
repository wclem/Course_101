def snake(str)
    words = str.split
    current_word = 0
  
    loop do
      words[current_word].downcase!
  
      current_word += 1
      break if current_word >= words.size
    end
  
    words.join('_')
  end

def camel(str)
words = str.split(' ')
counter = 0

while counter < words.size
    words[counter] = words[counter].capitalize

    counter = counter + 1
end

words.join
end

def upper_snake(str)
    words = str.split
    current_word = -1
  
    loop do
      current_word += 1
      break if current_word == words.size
  
      words[current_word].upcase!
    end
  
    words.join('_')
  end

sentence = 'The sky was blue'
puts snake(sentence) # => 'the_sky_was_blue'
puts camel(sentence) # => 'TheSkyWasBlue'
puts upper_snake(sentence) # => 'THE_SKY_WAS_BLUE'