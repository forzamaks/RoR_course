month_days = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_count = 0

puts 'Введите год:'
year = gets.chomp.to_i
puts 'Введите месяц:'
month = gets.chomp.to_i
puts 'Введите день:'
day = gets.chomp.to_i


if year % 4 == 0 || year % 400 == 0
  month_days[1] = 29
end


i = 0
while i < month do
  if i == month - 1
    days_count += day
  else
    days_count += month_days[i]
  end
  i += 1
end


puts "колличество дней с начала года #{days_count}"