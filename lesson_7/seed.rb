require_relative 'modules/set_name'
require_relative 'modules/instance_counter'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'

require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'

PassengerTrain.new('qaz-zz', 'passenger')
CargoTrain.new('asd-zz', 'cargo')

PassengerCarriage.new('q', 24)
CargoCarriage.new('1', 1000)

# pt.add_carriage(pc)
# ct.add_carriage(cc)

# puts pt