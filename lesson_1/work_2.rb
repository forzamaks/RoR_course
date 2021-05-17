puts 'Введите значение основания треугольника:'
length = gets.chomp.to_i
puts 'Введите значение высоты треугольника:'
height = gets.chomp.to_i

square = 0.5 * length * height

puts "Площадь треугольника равна: #{square}"