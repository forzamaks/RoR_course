class CargoCarriage < Carriage
  def initialize(number)
    super(number)
    @type = 'cargo'
  end
end