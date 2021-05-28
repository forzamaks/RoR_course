# frozen_string_literal: true

# Station Class
class Station
  include InstanceCounter
  include Validation

  attr_accessor :trains, :stations
  attr_reader :name

  
  # rubocop:disable Style/ClassVars
  @@stations = []
  # rubocop:enable Style/ClassVars

  def self.all
    @@stations
  end

  validate :name, :presence
  validate :station, :type, Station

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self

    @state = true

    register_instance(self.class)
    valid?
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    @trains = @trains.reject { |item| item.number == train.number }
    @trains
  end

  def all_trains_by_type(type)
    @trains.map { |train| train.type == type }
  end

  def show_trains_on_station
    @trains.each(&block)
  end
end
