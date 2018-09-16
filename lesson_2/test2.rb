def greetings
    yield
    puts 'Goodbye'
end

word = 'Hello'

greetings 
