to_search = ARGV[0]
file = ARGV[1]

File.open(file, 'r').each do |line|
  puts line if line =~ /#{to_search}/
end
