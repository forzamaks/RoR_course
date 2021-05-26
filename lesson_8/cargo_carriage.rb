# frozen_string_literal: true

# CargoCarriage Class
class CargoCarriage < Carriage
  attr_accessor :occupied_volume

  def initialize(number, volume)
    super(number)
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def assign_volume(volume)
    self.volume = volume
  end

  def availible_volume
    volume - occupied_volume
  end
end
