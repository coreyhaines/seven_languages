sixteen_numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]

to_print = ""
count = 0
sixteen_numbers.each do |number|
  if count < 4
    to_print += number.to_s + " "
    count += 1
  else
    puts to_print
    count = 1
    to_print = number.to_s + " "
  end
end
puts to_print



