class Station
  include InstanceCounter

  attr_accessor :trains
  attr_reader :name
  
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self

    @state = true
    
    register_instance(self.class)
    begin
      validate!
    rescue RuntimeError => e
      puts e.message
    end
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

  def valid?
    validate!
      true
  rescue
    false
  end

  protected

  def validate!
    errors = []
    errors << "Название станции не может быть пустым" if name.length.zero?
    errors << "Название станции должно иметь минимум 3 символа" if name.length < 3
    raise errors.join('. ') unless errors.empty?
  end

end