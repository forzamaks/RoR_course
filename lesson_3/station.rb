class Station
  attr_accessor :trains
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains = @trains.reject {|item| item.number == train.number}
    return @trains
  end

  def all_trains_by_type(type)
    trains_by_type = @trains.map {|train| train.type == type}
    return trains_by_type
  end
end