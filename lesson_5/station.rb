class Station
  include InstanceCounter

  attr_accessor :trains
  attr_reader :name
  
  @@stations = []

  def self.all
    @@stations
  end

  # increment
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    
    register_instance(self.class)
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    @trains = @trains.reject {|item| item.number == train.number}
    @trains
  end

  def all_trains_by_type(type)
    trains_by_type = @trains.map {|train| train.type == type}
    trains_by_type
  end
end