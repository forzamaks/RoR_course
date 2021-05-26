# frozen_string_literal: true

# Station Class
class Station
  include InstanceCounter

  attr_accessor :trains, :stations
  attr_reader :name

  # rubocop:disable Style/ClassVars
  @@stations = []
  # rubocop:enable Style/ClassVars

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    # @stations = []
    @@stations << self

    @state = true

    register_instance(self.class)
    exceptions!
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def exceptions!
    validate!
  rescue RuntimeError => e
    puts e.message
  end

  def validate!
    errors = []
    errors << 'Название станции не может быть пустым' if name.length.zero?
    errors << 'Название станции должно иметь минимум 3 символа' if name.length < 3
    raise errors.join('. ') unless errors.empty?
  end
end
