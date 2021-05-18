numbers = []

loop do
  if numbers.length < 2
    numbers.push(numbers.length)
  else
    i = numbers[numbers.length - 1] + numbers[numbers.length - 2]
    break if i > 100
    numbers.push(i)
  end
end

