puts 'Введите длинну первой стороны треугольника:'
a = gets.chomp.to_i
puts 'Введите длинну второй стороны треугольника:'
b = gets.chomp.to_i
puts 'Введите длинну третьей стороны треугольника:'
c = gets.chomp.to_i

sides = [a, b, c].sort

if a == b && a == c && b == c
  puts 'Треугольник является равнобедренным и равносторонним' 
elsif a == b || a == c || b == c
  puts 'Треугольник является равнобедренным'
else
  is_rectangular = sides[0]**2 + sides[1]**2 == sides[2]**2
  if is_rectangular
    puts 'Треугольник прямоугольный'
  else
    puts 'Треугольник не прямоугольный'
  end
end