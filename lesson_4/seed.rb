a = Station.new('a')
b = Station.new('b')
c = Station.new('c')
d = Station.new('d')


route = Route.new(a, b)
route.add_station(c)
route.add_station(d)

load './main.rb'

ct = CargoTrain.new('123', 'cargo')
pt = PassengerTrain.new('234', 'passenger')

pc = PassengerCarriage.new

pt.add_carriage(pc)

pt.delete_carriage(pc)

pt.train_add_route(route)
ct.train_add_route(route)

ct.change_to_next_station(route)

ct.show_current_prew_next_stations(route)