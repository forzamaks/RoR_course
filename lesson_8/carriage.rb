# frozen_string_literal: true

# Carriage Class
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
  rescue StandardError
    false
  end

  protected

  def validate!
    errors = []
    errors << 'Номер вагона не может быть пустым' if number.length.zero?
    raise errors.join('. ') unless errors.empty?
  end
end
