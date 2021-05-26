module FuelTank
  def fuel_tank(level)
    self.fuel_tank = level

  end

  def fuel_level
    self.fuel_tank

  end
  protected 
  attr_accessor :fuel_tank
end


module Debbuger

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  module ClassMethods
    def debbug(log)
      puts "!!DEBBUG #{{log} !!!!"
    end
  end
  module InstanceMethods
    def debbug(log)
      self.class.debug(log)
    end
  end

end

class Car
  include FuelTank
  include Debbuger

  attr_reader :current_rpm
  @@instansies = 0

  def self.instansies
    @@instansies
  end

  def self.debug(log)
    puts "!!DEBBUG #{{log} !!!!"
  end
  def initialize
    current_rpm = 0
    @@instansies +=1
  end



  debug 'Start interace'
  def start_engine
    start_engine! if engine_stopped?
  end

  def engine_stopped?
    current_rpm.zero?
  end
  debug 'end'
  protected

  attr_writer :current_rpm


  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end
end

class Truck < Car

  def loading

  end

  protected

  def initial_rpm
    500
  end

end

class SportCar < Car
  protected

  def initial_rpm
    1000
  end
end