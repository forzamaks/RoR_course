puts 'Введите ваше имя?'
name = gets.chomp
puts 'Введите ваш рост?'
height = gets.chomp.to_i
weight = (height - 110) * 1.15
if weight < 0
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес: #{weight}"
end