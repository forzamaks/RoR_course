puts "Введите длинну первой стороны треугольника:"
a = gets.chomp.to_f
puts "Введите длинну второй стороны треугольника:"
b = gets.chomp.to_f
puts "Введите длинну третьей стороны треугольника:"
c = gets.chomp.to_f

if a == b && a == c && b == c
  puts "Треугольник является равнобедренным и равносторонним" 
elsif a == b || a == c || b == c
  puts "Треугольник является равнобедренным" 
else
  if (a > b && a > c)
    is_rectangular = b**2 + c**2 == a**2
    if is_rectangular
      puts "Треугольник прямоугольный"
    else
      puts "Треугольник не прямоугольный"
    end
  elsif (b > a && b > c)
    is_rectangular = a**2 + c**2 == b**2
    if is_rectangular
      puts "Треугольник прямоугольный"
    else
      puts "Треугольник не прямоугольный"
    end
  elsif (c > a && c > b)
    is_rectangular = a**2 + b**2 == c**2
    if is_rectangular
      puts "Треугольник прямоугольный"
    else
      puts "Треугольник не прямоугольный"
    end
  else 
    puts "треугольник разносторонний"
  end
end