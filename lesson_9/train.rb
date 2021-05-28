# frozen_string_literal: true

# Train Class
class Train
  include SetName
  include InstanceCounter
  include Validation


  attr_reader :number, :type
  attr_accessor :speed, :cars, :trains
  

  NUMER_TMP = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMER_TMP
  

  # rubocop:disable Style/ClassVars
  @@trains = {}
  # rubocop:enable Style/ClassVars
  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    @@trains[number] = self

    register_instance(self.class)

    valid?
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
    route.assign_train(self)
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
    cars << carriage if type == carriage.type && speed.zero?
  end

  def delete_carriage(carriage)
    self.cars = cars.reject { |item| item.number == carriage.number } if speed.zero?
    cars
  end

  def show_carriage_in_train
    @cars.each(&block)
  end

  protected

  # def exceptions!
  #   validate!
  # rescue RuntimeError => e
  #   puts e.message
  # end

end
