class Route 
  attr_accessor :stations
  include InstanceCounter
  
  def initialize(start_station, finish_station, number)
    @start_station = start_station
    @finish_station = finish_station
    @number = number
    @stations = []
    register_instance(self.class)

    begin
      validate!
    rescue RuntimeError => e
      puts e.message
    end
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
        if type == :next
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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    errors = []
    errors << "Название станции начала маршрута не может быть пустым и должно иметь минимум 3 символа" if @start_station.name.length.zero? && @start_station.name.length < 3
    errors << "Название станции конца маршрута не может быть пустым и должно иметь минимум 3 символа" if @finish_station.name.length.zero? && @finish_station.name.length < 3
    errors << "Номер маршрута не может быть пустым" if @number.length.zero?
    raise errors.join('. ') unless errors.empty?
  end
end