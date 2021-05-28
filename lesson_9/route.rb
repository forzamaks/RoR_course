# frozen_string_literal: true

# Route Class
class Route
  SMALL_LENGTH_NAME = 'Название должно иметь минимум 3 символа'
  STATION = 'Не указано название станции'
  attr_accessor :stations

  include InstanceCounter
  include Validation

  validate :start_station, :presence
  validate :finish_station, :presence
  validate :number, :presence

  def initialize(start_station, finish_station, number)
    @start_station = start_station
    @finish_station = finish_station
    @number = number
    @stations = []
    register_instance(self.class)

    valid?

  end

  def add_station(station)
    @stations << station
  end

  def remove_station(station)
    @stations = @stations.reject { |item| item.name == station.name }
    @stations
  end

  def receive_all_routes
    all_routes = @stations
    all_routes.unshift(@start_station) unless all_routes.include?(@start_station)
    all_routes.push(@finish_station) unless all_routes.include?(@finish_station)
    all_routes.uniq
    all_routes
  end

  def assign_train(train)
    @start_station.add_train(train)
  end

  def change_station(train, _type)
    stations_list = receive_all_routes
    new_station = []
    stations_list.each_with_index do |station, _index|
      new_station = new_station_to_train(type) if station.trains.include?(train)
      station.delete_train(train)
    end
    new_station.add_train(train)
  end

  def new_station_to_train(type)
    previous = index - 1
    next_station = index + 1
    end_station = stations_list.length - 1
    if type == :next
      stations_list[next_station > end_station ? end_station : inext_station]
    else
      stations_list[previous.negative? ? 0 : previous]
    end
  end

  def show_stations_nearby(train)
    stations_list = receive_all_routes
    stations_list.each_with_index do |station, index|
      previous = index - 1
      next_station = index + 1
      next unless station.trains.include?(train)

      puts "предыдущая станция: #{stations_list[previous].name}" if previous >= 0
      puts "текущая станция: #{station.name}"
      puts "следущая станция: #{stations_list[next_station].name}" if next_station < stations_list.length
    end
  end
end
