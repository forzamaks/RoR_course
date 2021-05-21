class Train
  attr_accessor :speed, :cars
  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def current_speed
    speed
  end

  def run(speed)
    self.speed = speed
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

  def add_carriage(carriage)
    self.cars << carriage if type == carriage.type && speed.zero?
  end

  def delete_carriage(carriage)
    if speed.zero?
      self.cars = self.cars.reject {|item| item.number == carriage.number}
    end
    return self.cars
  end
end