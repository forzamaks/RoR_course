class Train
  attr_accessor :speed 
  attr_reader :number_of_cars, :train_number, :type

  def initialize(train_number, type, number_of_cars)
    @train_number = train_number
    @type = type
    @number_of_cars = number_of_cars
  end

  def stop
    self.speed = 0
  end

  def current_speed
    self.speed
  end

  def run(speed)
    self.speed = speed
  end

  def add_cars
    @number_of_cars += 1 if self.speed == 0
  end

  def delete_cars
    @number_of_cars -= 1 if self.speed == 0
  end

  def train_add_route(route)
    route.set_train(self)
  end

  def change_to_next_station(route)
    route.change_station(self, 'next')
  end

  def change_to_prew_station(route)
    route.change_station(self, 'prew')
  end

  def show_current_prew_next_stations(route)
    route.show_stations_nearby(self)
  end
end