class Carriage
  include SetName
  attr_accessor :type, :number

  def initialize(number)
    @number = number
    begin
      validate!
    rescue RuntimeError => e
      puts e.message
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Номер вагона не может быть пустым" if number.length.zero?

  end
end
