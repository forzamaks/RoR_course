class PassengerCarriage < Carriage
  attr_accessor :occupied_places
  attr_reader :places
  def initialize(number, places)
    super(number)
    @type = 'passenger'
    @places = places.to_i
    @occupied_places = 0
  end

  def take_place
    self.occupied_places += 1
  end

  def show_free_places
    places - occupied_places
  end

  def show_occupied_places
    self.occupied_places
  end

end 