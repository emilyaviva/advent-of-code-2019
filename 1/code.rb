input = File.readlines('input').map(&:chomp)

def calculate_fuel(mass)
  (mass.to_i / 3) - 2
end

# part A
puts input.map{|n| calculate_fuel(n)}.sum

# part B
total_fuel = 0
input.each do |i|
  more_fuel = calculate_fuel(i)
  while more_fuel > 0
    total_fuel += more_fuel
    more_fuel = calculate_fuel(more_fuel)
  end
end

puts total_fuel
