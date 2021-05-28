# frozen_string_literal: true

require_relative 'modules/set_name'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'

require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'

# Main Class
class Main
  NAME_STATION = 'Введите название станции'
  NUMBER_TRAIN = 'Введите номер поезда'
  START_STATION = 'Введите станцию начала маршрута'
  FINISH_STATION = 'Введите станцию окончания маршрута'
  NUMBER_ROUTE = 'Введите номер маршрута'

  attr_accessor  :routes

  def initialize
    @routes = {}
  end

  def routes_control_submenu(menu, route_control)
    loop do
      menu.each { |item| puts item }
      input = gets.to_i
      routes_control_action(input, route_control)
    end
  end

  def routes_control_action(input, route_control)
    case input
    when 1
      route_control.create_route_menu
    when 2
      route_control.add_station_to_route_menu(:add)
    when 3
      route_control.add_station_to_route_menu(:remove)
    end
  end

  def carriage_control_menu(menu, train_control)
    loop do
      menu.each { |item| puts item }
      input = gets.to_i
      carriage_control_action(input, train_control)
    end
  end

  def carriage_control_action(input, train_control)
    case input
    when 1
      train_control.control_carriage_menu(:add)
    when 2
      train_control.control_carriage_menu(:remove)
    end
  end

  protected

  def station?(name)
    has_station = []
    Station.all.select { |item| has_station << item if item.name == name }
    false if has_station.length.zero?
    true if has_station.length.positive?
  end

  def carriage?(number, cars)
    has_carriage = []
    cars.select { |item| has_carriage << item if item.number == number }
    false if has_carriage.empty?
    true if has_carriage.length.positive?
  end

  def route?(number)
    has_route = []
    has_route << routes[number] if routes[number]
    false if has_route.empty?
    true if has_route.length.positive?
  end
end

# StationControl Class
class StationControl < Main
  def station_menu
    puts NAME_STATION
    name = gets.chomp
    if station?(name)
      puts 'станция уже существует'
    else
      create_station(name)
    end
  end

  def show_stations_list_on_route
    puts NUMBER_ROUTE
    number = gets.chomp
    if route?(number)
      route = routes[number]
      route.receive_all_routes
      puts 'Станции на маршруте:'
      route.stations.map { |station| puts station.name }
    else
      puts 'Маршрут не найден'
    end
  end

  def show_trains_on_station
    puts NAME_STATION
    name = gets.chomp
    if station?(name)
      station = Station.all.select { |item| item.name == name }
      puts 'Список поездов на станции'
      station.trains.map { |train| puts train.number }
    else
      puts 'Станция не найдена'
    end
  end

  def show_trains_list_station
    puts NAME_STATION
    name = gets.chomp
    if station?(name)
      station = Station.all.select { |item| item.name == name }
      station.show_trains_on_station do |train|
        puts "Номер поезда: #{train.number}. Тип поезда: #{train.type}. Колличество вагонов: #{train.cars.length}."
      end
    else
      puts 'Станция не найдена'
    end
  end

  protected

  def create_station(name)
    station = Station.new(name)
    puts 'станция создана' if station.valid?
    create_station unless station.valid?
  end
end

# TrainControl Class
class TrainControl < Main
  def train_menu
    puts NUMBER_TRAIN
    number = gets.chomp
    loop do
      puts '1. Пассажирский'
      puts '2. Грузовой'
      input = gets.to_i
      break unless [1, 2].include?(input)

      create_train(number, input)
    end
  end

  def control_carriage_menu(action)
    puts NUMBER_TRAIN
    number_train = gets.chomp
    puts 'Введите номер вагона'
    number_carriage = gets.chomp
    if Train.find(number_train)
      add_carriage_to_train(number_train) if action == :add
      remove_carriage_to_train(number_train, number_carriage) if action == :remove
    else
      puts 'Поезд не найден'
    end
  end

  def show_carriage_list_in_train
    puts NUMBER_TRAIN
    number = gets.chomp
    return unless Train.find(number)

    Train.find(number).show_carriage_in_train do |item|
      puts "Номер вагона: #{item.number}. Тип вагона: #{item.type}."
      show_information_carriage(item.type)
    end
  end

  def show_information_carriage(_type)
    puts "Свободно: #{item.free_places}, Занято: #{item.occupied_places}" if item.type == :passenger
    puts "Свободно: #{item.availible_volume}, Занято: #{item.occupied_volume}" if item.type == :cargo
  end

  def change_train_station_menu
    puts NUMBER_TRAIN
    number_train = gets.chomp
    puts NUMBER_ROUTE
    number_route = gets.chomp
    change_train_station_submenu(number_train, number_route)
  end

  def change_train_station_submenu(number_train, number_route)
    loop do
      puts '1. вперед'
      puts '2. назад'
      input = gets.to_i
      break unless [1, 2].include?(input)

      change_train_station(number_train, number_route)
    end
  end

  protected

  def create_train(number, input)
    train = PassengerTrain.new(number, :passenger) if input == 1
    train = CargoTrain.new(number, :cargo) if input == 2
    puts "создан поезд #{number}" if train.valid?
    train_menu unless train.valid?
  end

  def add_carriage_to_train(number)
    train = Train.find(number)
    puts 'Укажите колличество мест в вагоне' if train.type == :passenger
    puts 'Укажите объем вагона' if train.type == :cargo
    quantity = gets.chomp
    carriage = CargoCarriage.new(number, quantity) if train.type == :cargo
    carriage = PassengerCarriage.new(number, quantity) if train.type == :passenger
    train.add_carriage(carriage)
    puts 'Вагон добавлен к поезду'
  end

  def remove_carriage_to_train(number_train, number_carriage)
    train = Train.find(number_train)
    if carriage?(number_carriage, train.cars)
      carriage = cars.select { |item| item.name == name }
      train.delete_carriage(carriage)
      puts 'Вагон удален'
    else
      puts 'Вагон не найден'
    end
  end

  def change_train_station(number_train, number_route)
    if route?(number_route) && Train.find(number_train).present?
      train = Train.find(number_train)
      route = routes[number_route]

      train.change_to_next_station(route) if input == 1
      train.change_to_prew_station(route) if input == 2
      puts 'Поезд перемещен'
    else
      puts 'Поезд не найден'
    end
  end
end

# RouteControl Class
class RouteControl < Main
  def create_route_menu
    puts START_STATION
    start = gets.chomp
    puts FINISH_STATION
    finish = gets.chomp
    puts NUMBER_ROUTE
    number = gets.chomp

    create_route(start, finish, number)
  end

  def add_route_to_train_menu
    puts NUMBER_ROUTE
    number_route = gets.chomp
    puts NUMBER_TRAIN
    number_train = gets.chomp
    if route?(number_route) && Train.find(number_train).present?
      add_route_to_train(number_route, number_train)
    else
      puts 'Не верно указан номер поезда или номер маршрута'
    end
  end

  def add_station_to_route_menu(action)
    puts NAME_STATION
    name = gets.chomp
    puts NUMBER_ROUTE
    number = gets.chomp
    add_station_to_route(name, number, action) if action == :add
    remove_station_on_route(name, number, action) if action == :remove
  end

  def add_station_to_route(name, number, action)
    station = station?(name) ? Station.all.select { |item| item.name == name } : Station.new(name)
    if route?(number)
      route_action(action, number, station)
    else
      puts 'Маршрут не найден'
    end
  end

  def remove_station_on_route(name, number, action)
    if station?(name)
      station = Station.all.select { |item| item.name == name }
    else
      puts 'Станция не найдена'
    end
    if route?(number)
      route_action(action, number, station)
    else
      puts 'Маршрут не найден'
    end
  end

  def route_action(action, number, station)
    route = routes[number]
    case action
    when :remove
      route.remove_station(station.first)
      puts 'Станция удалена с маршрута'
    when :add
      route.add_station(station)
      puts 'Станция добавлена на маршрут'
    end
  end

  protected

  def create_route(start, finish, number)
    start = station?(start) ? Station.all.select { |item| item.name == start } : Station.new(start)
    finsih = station?(finish) ? Station.all.select { |item| item.name == finish } : Station.new(finish)
    route = Route.new(start, finsih, number)
    routes[number] = route
    puts 'Маршрут создан'
  end

  def add_route_to_train(number_route, number_train)
    train = Train.find(number_train)
    route = routes[number_route]
    train.train_add_route(route)
  end
end

main = Main.new
menu = [
  '1. Создать новую станцию',
  '2. Добавить поезд',
  '3. Создать маршрут и управлять станциями',
  '4. Назначить маршрут поезду',
  '5. Добавить или отцепить вагоны',
  '6. Посмотреть список станций ',
  '7. Посмотреть список поездов на станции',
  '8. Переместить поезд',
  '9. Показать список вагонов у поезда',
  '10. Показать список поездов на стании',
  '0. Выход',
  'Выберите вариант:'
]
routes_menu = [
  '1. Создать новый маршрут',
  '2. Добавить станцию на маршрут',
  '3. Удалить станцию на маршруте'
]

carriage_menu = ['1. Добавить вагон', '2. Удалить вагон']

station_control = StationControl.new
train_control = TrainControl.new
route_control = RouteControl.new

loop do
  menu.each { |item| puts item }
  input = gets.chomp
  break if input.to_i.zero? || input == 'Стоп'

  case input.to_i
  when 1
    station_control.station_menu
  when 2
    train_control.train_menu
  when 3
    main.routes_control_submenu(routes_menu, route_control)
  when 4
    route_control.add_route_to_train_menu
  when 5
    main.carriage_control_menu(carriage_menu, train_control)
  when 6
    station_control.show_stations_list_on_route
  when 7
    station_control.show_trains_on_station
  when 8
    train_control.change_train_station_menu
  when 9
    train_control.show_carriage_list_in_train
  when 10
    station_control.show_trains_list_station
  end
end
