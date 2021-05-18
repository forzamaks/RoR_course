basket = Hash.new
total_amount = 0

loop do
  puts 'Введите название товара:'
  title = gets.chomp
  break if title.downcase == 'стоп'
  puts 'Введите цену товара:'
  price = gets.chomp.to_i
  puts 'Введите колличество товара:'
  quantity = gets.chomp.to_f
  basket[title] = {"price" => price, "quantity" => quantity}
  
end

puts basket

basket.each do |key, value|
  amount = value["price"] * value["quantity"]
  total_amount += amount
  puts "Стоимость #{key} составляет #{amount}"
end

puts "Общая стоимость покупок составляет #{total_amount}"