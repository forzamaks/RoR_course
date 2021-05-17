puts "Введите значение основания треугольника:"
length = gets.chomp
puts "Введите значение высоты треугольника:"
height = gets.chomp

square = 0.5 * length.to_i * height.to_i

puts "Площадь треугольника равна: #{square}"