# Calculator program
print "Please enter the loan amount: "
loan_amt = gets().chomp().to_f()

apr = 0
loop do
  print "Please enter the APR as a percentage: "
  apr = gets().chomp().to_f()
  if apr.between?(0, 100) then break end
end

duration_years = 0
loop do
  print "Please enter the loan duration, in years: "
  duration_years = gets().chomp().to_i()
  if duration_years > 0 then break end
end

# Convert APR to effective monthly rate
monthly_interest_rate = (1 + apr / 100.0)**(1 / 12.0) - 1
duration_months = duration_years * 12

# Calculate monthly payment
monthly_payment = loan_amt *
  (monthly_interest_rate /
  (1 - (1 + monthly_interest_rate)**-duration_months))

mir = format("%0.4f", monthly_interest_rate * 100)
puts "Your monthly interest rate is %#{mir}"
mp = format("%0.2f", monthly_payment)
puts "Your monthly payment is $#{mp}."
