require_relative 'modules/set_name'
require_relative 'modules/instance_counter'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'

require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'

class Main
  NAME_STATION = 'Введите название станции'
  NUMBER_TRAIN = 'Введите номер поезда'
  START_STATION = 'Введите станцию начала маршрута'
  FINISH_STATION = 'Введите станцию окончания маршрута'
  NUMBER_ROUTE = 'Введите номер маршрута'

  attr_accessor  :routes

  def initialize
    @routes = Hash.new
  end

  def create_station
    puts NAME_STATION
    name = gets.chomp

    if has_station!(name).length.zero?
      station = Station.new(name) 
      # stations << station if station
      puts "станция создана"
    else
      puts "станция уже существует"
    end
    
  end

  def create_train
    puts NUMBER_TRAIN
    number = gets.chomp

    loop do
      puts '1. Пассажирский'
      puts '2. Грузовой'
      input = gets.to_i
      break unless input == 1 || input == 2

      train = PassengerTrain.new(number, 'passenger') if input == 1
      train = CargoTrain.new(number, 'cargo') if input == 2
      # trains[number] = train if train
      break
    end
  end

  def create_route
    puts START_STATION
    start_route = gets.chomp
    puts FINISH_STATION
    finish_route = gets.chomp
    puts NUMBER_ROUTE
    number = gets.chomp
    if has_station!(start_route).length.zero?
      start_station = Station.new(start_route)
      # self.stations << start_station
    else 
      start_station = Station.all.select{|item| item.name == start_route}
    end
    if has_station!(finish_route).length.zero?
      finsih_station = Station.new(finish_route)
      # self.stations << finsih_station
    else 
      finsih_station = Station.all.select{|item| item.name == finish_route}
    end
    route = Route.new(start_station, finsih_station, number)
    routes[number] = route

    puts 'Маршрут создан'
  end

  def add_station_to_route
    puts NAME_STATION
    name = gets.chomp
    puts NUMBER_ROUTE
    number = gets.chomp

    if has_station!(name).length.zero?
      station = Station.new(name)
      # self.stations << station
    else 
      station = Station.all.select{|item| item.name == name}
    end
    if has_route!(number).length.zero?
      puts 'Маршрут не найден'
    else 
      route = has_route!(number).first
      route.add_station(station)
      puts 'Станция добавлена на маршрут'
    end
  end
  def remove_station_on_route
    puts NAME_STATION
    name = gets.chomp
    puts NUMBER_ROUTE
    number = gets.chomp

    if has_station!(name).length.zero?
      puts 'Станция не найдена'
    else 
      station = Station.all.select{|item| item.name == name}

    end
    if has_route!(number).length.zero?
      puts 'Маршрут не найден'
    else 
      route = has_route!(number).first
      route.remove_station(station.first)
      puts 'Станция удалена с маршрута'
    end
  end

  def add_route_to_train
    puts NUMBER_ROUTE
    number_route = gets.chomp
    puts NUMBER_TRAIN
    number_train = gets.chomp

    unless has_route!(number_route).length.zero? && Train.find(number_train)
      train = Train.find(number_train)
      route = has_route!(number_route).first
      train.train_add_route(route)
    else
      puts 'Не верно указан номер поезда или номер маршрута'
    end
  end

  def show_stations_list_on_route
    puts NUMBER_ROUTE
    number = gets.chomp
    if has_route!(number).length.zero?
      puts 'Маршрут не найден'
    else 
      route = has_route!(number).first
      route.get_all_routes
      puts "Станции на маршруте:"
      route.stations.map {|station| puts station.name}
    end
  end

  def add_carriage_to_train
    puts NUMBER_TRAIN
    number_train = gets.chomp
    puts 'Введите номер вагона'
    number_carriage = gets.chomp

    unless Train.find(number_train)
      train = Train.find(number_train)
      carriage = CargoCarriage.new(number_carriage) if train.type == 'cargo'
      carriage = PassengerCarriage.new(number_carriage) if train.type == 'passenger'
      
      train.add_carriage(carriage)
      puts 'Вагон добавлен к поезду'
    else
      puts 'Поезд не найден'
    end
  end
  def remove_carriage_to_train
    puts NUMBER_TRAIN
    number_train = gets.chomp
    puts 'Введите номер вагона'
    number_carriage = gets.chomp

    unless Train.find(number_train)
      train = Train.find(number_train)
      unless has_carriage!(number_carriage, train.cars).length.zero?

        train.delete_carriage(has_carriage!(number_carriage, train.cars).first)
        puts 'Вагон удален'
      else 
        puts 'Вагон не найден'
      end
    else
      puts 'Поезд не найден'
    end
  end

  def show_trains_on_station
    puts NAME_STATION
    name = gets.chomp

    unless has_station!(name).length.zero?
      station = has_station!(name).first
      puts 'Список поездов на станции'
      station.trains.map {|train| puts train.number}
    else
      puts 'Станция не найдена'
    end
  end

  def change_train_station
    puts NUMBER_TRAIN
    number_train = gets.chomp
    puts NUMBER_ROUTE
    number_route = gets.chomp
    loop do
      puts '1. вперед'
      puts '2. назад'
      input = gets.to_i
      break unless input == 1 || input == 2

      unless has_route!(number_route).length.zero? && Train.find(number_train)
        train = Train.find(number_train)
        route = has_route!(number_route).first

        
        train.change_to_next_station(route) if input == 1
        train.change_to_prew_station(route) if input == 2
        puts 'Поезд перемещен'
      else
        puts 'Поезд не найден'
      end

      break
    end
  end

  private
  # данные методы вынес в раздел private так как использую их внутри public методов как  вспомогательные методы класса
  def has_station!(name)
    has_station = []
    Station.all.select {|item| has_station << item if item.name == name}
    has_station
  end
  def has_carriage!(number, cars)
    has_carriage = []
    cars.select {|item| has_carriage << item if item.number == number}
    has_carriage
  end
  def has_route!(number)
    has_route = []
    has_route << routes[number] if routes[number]
    has_route
  end
  
end

main = Main.new

loop do
  puts '1. Создать новую станцию'
  puts '2. Добавить поезд'
  puts '3. Создать маршрут и управлять станциями'
  puts '4. Назначить маршрут поезду'
  puts '5. Добавить или отцепить вагоны'
  puts '6. Посмотреть список станций '
  puts '7. Посмотреть список поездов на станции'
  puts '8. Переместить поезд'
  puts '0. Выход'
  puts 'Выберите вариант: '
  
  input = gets.chomp
  break if input.to_i == 0 || input == 'Стоп'

  if input.to_i == 1

    main.create_station

  elsif input.to_i == 2

    main.create_train

  elsif input.to_i == 3
    loop do
      puts '1. Создать новый маршрут'
      puts '2. Добавить станцию на маршрут'
      puts '3. Удалить станцию на маршруте'
      input = gets.to_i
      if input == 1
        main.create_route
        break
      elsif input == 2
        main.add_station_to_route
        break
      elsif input == 3
        main.remove_station_on_route
        break
      else
        break
      end
    end
  elsif input.to_i == 4
    main.add_route_to_train

  elsif input.to_i == 5
    loop do
      puts '1. Добавить вагон'
      puts '2. Удалить вагон'
      input = gets.to_i
      if input == 1
        main.add_carriage_to_train
        break
      elsif input == 2
        main.remove_carriage_to_train
        break
      else
        break
      end
    end
  elsif input.to_i == 6
    main.show_stations_list_on_route
  elsif input.to_i == 7
    main.show_trains_on_station
  elsif input.to_i == 8
    main.change_train_station
  end
end