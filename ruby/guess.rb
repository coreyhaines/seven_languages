number= rand(10)


guess = -1
until guess == number 
  puts "Pick a number:"
  guess = gets.to_i

  if guess < number
    puts "Too low"
  else
    puts "Too high"
  end
end

puts "You guess it. The number was #{guess}"
