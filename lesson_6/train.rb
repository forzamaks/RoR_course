class Train
  include SetName
  include InstanceCounter

  attr_accessor :speed, :cars
  attr_reader :number, :type

  NUMER_TMP = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i

  @@trains = Hash.new

  def self.find(number)
    @@trains[number] if @@trains[number]
  end

  def initialize(number, type)
    
    @number = number
    @type = type
    @cars = []
    @speed = 0
    @@trains[number] = self
    register_instance(self.class)
    
    begin
      validate!
    rescue RuntimeError => e
      puts e.message
    end
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
    route.change_station(self, :next)
  end

  def change_to_prew_station(route)
    route.change_station(self, :prev)
  end

  def show_current_prew_next_stations(route)
    route.show_stations_nearby(self)
  end

  def add_carriage(carriage)
    self.cars << carriage if type == carriage.type && speed.zero?
  end

  def delete_carriage(carriage)
    if speed.zero?
      self.cars = cars.reject {|item| item.number == carriage.number}
    end
    cars
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
    errors << "Номер поезда не может быть пустым" if number.length.zero?
    errors << "Номер поезда должен иметь минимум 5 символов" if number.length < 5
    errors << "Неверный формат номера поезда" if number !~ NUMER_TMP
    
    raise errors.join('. ') unless errors.empty?
  end
end