class Route 
  attr_accessor :stations
  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = []
  end

  def add_stations(station)
    @stations << station
  end

  def remove_stations(station)
    @stations.map {|item| item != station }
  end

  def show_all_route
    # all_route = []
    all_route = @stations
    all_route.unshift(@start_station) unless all_route.include?(@start_station)
    all_route.push(@finish_station) unless all_route.include?(@finish_station)
    all_route.uniq
    #return all_route
  end

  def set_train(train)
    @start_station.add_train(train)
  end

  def change_station(train, type)
    station_list = self.show_all_route
    new_station = []
    station_list.each_with_index do |station, index|
      if station.trains.include?(train)
        if type == 'next'
          new_station = station_list[index + 1 > station_list.length - 1 ? station_list.length - 1 : index + 1]
        else
          new_station = station_list[index - 1 < 0 ? 0 : index - 1]
        end
        puts new_station
      end
      station.delete_train(train)
    end
    new_station.add_train(train)
    
  end

  def show_stations_nearby(train)
    station_list = self.show_all_route
    station_list.each_with_index do |station, index|
      if station.trains.include?(train)
        puts "предыдущая станция: #{station_list[index - 1].name}" if index - 1 >= 0
        puts "текущая станция: #{station.name}"
        puts "следущая станция: #{station_list[index + 1].name}" if index + 1 < station_list.length 
      end
    end
    
  end
end