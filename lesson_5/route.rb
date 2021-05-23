class Route 
  attr_accessor :stations
  include InstanceCounter
  
  def initialize(start_station, finish_station, number)
    @start_station = start_station
    @finish_station = finish_station
    @number = number
    @stations = []
    register_instance(self.class)
  end

  def add_station(station)
    @stations << station
  end

  def remove_station(station)
    @stations = @stations.reject {|item| item.name == station.name }
    @stations
  end

  def get_all_routes
    all_routes = @stations
    all_routes.unshift(@start_station) unless all_routes.include?(@start_station)
    all_routes.push(@finish_station) unless all_routes.include?(@finish_station)
    all_routes.uniq
    all_routes
  end

  def set_train(train)
    @start_station.add_train(train)
  end

  def change_station(train, type)
    stations_list = get_all_routes
    new_station = []
    stations_list.each_with_index do |station, index|
      if station.trains.include?(train)
        if type == 'next'
          new_station = stations_list[index + 1 > stations_list.length - 1 ? stations_list.length - 1 : index + 1]
        else
          new_station = stations_list[index - 1 < 0 ? 0 : index - 1]
        end
        puts new_station
      end
      station.delete_train(train)
    end
    new_station.add_train(train)
    
  end

  def show_stations_nearby(train)
    stations_list = get_all_routes
    stations_list.each_with_index do |station, index|
      if station.trains.include?(train)
        puts "предыдущая станция: #{stations_list[index - 1].name}" if index - 1 >= 0
        puts "текущая станция: #{station.name}"
        puts "следущая станция: #{stations_list[index + 1].name}" if index + 1 < stations_list.length 
      end
    end
    
  end
end