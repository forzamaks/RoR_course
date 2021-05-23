class Carriage
  include SetName
  attr_accessor :type, :number

  def initialize(number)
    @number = number
  end
end
