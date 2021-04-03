class Route
  # Имеет начальную и конечную станцию, а также список промежуточных станций. 
  # Начальная и конечная станции указываютсся при создании маршрута, 
  # а промежуточные могут добавляться между ними.
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    #@stations.unshift(@first_station)
    #@stations << @last_station
  end

  # Может добавлять промежуточную станцию в список
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Может удалять промежуточную станцию из списка
  def del_station(station)
    @stations.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def show_stations
    @stations.each{|station| puts station.name}
  end

  def show_first_station
    @first_station
  end
  
end

class Station
  attr_reader :name
  # Имеет название, которое указывается при ее создании
  def initialize(name)
    @name = name
    @trains = []
  end

  # Может принимать поезда (по одному за раз)
  def reception(train)
    @trains << train
  end

  # Может возвращать список всех поездов на станции, находящиеся в текущий 
  # момент
  def train_list
    @trains
  end

  def show_trains
    @trains.each{|train| puts train.number}
  end

  # Может возвращать список поездов на станции по типу (см. ниже): 
  # кол-во грузовых, пассажирских
  def train_list_type
    @trains_pass_count = 0
    @trains.each{|train| @trains_pass_count += 1 if train.type == 'пассажирский'}
    @trains_gruz_count = 0
    @trains.each{|train| @trains_gruz_count += 1 if train.type == 'грузовой'}
    puts "Количество пассажирских #{@trains_pass_count}"
    puts "Количество Грузовых #{@trains_gruz_count}"
  end

  # Может отправлять поезда (по одному за раз, при этом, 
  # поезд удаляется из списка поездов, находящихся на станции).  
  def send_train(train)
    @trains.delete(train)
  end
end

class Train
  attr_accessor :speed
  attr_reader :number, :type, :quantity
  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество 
  # вагонов, эти данные указываются при создании экземпляра класса
  def initialize(number, type, quantity)
    @number = number
    @quantity = quantity
    @train_station = []
    @index = 0
    @type = type if (type == 'грузовой') || (type == 'пассажирский')
  end

  # Может набирать скорость
  #def speed(speed)
   # @speed = speed
  #end

  # Может возвращать текущую скорость
  #def current_speed
   # @speed
  #end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

  # Может возвращать количество вагонов
  #def quantity_vagons
  ##  @quantity
  #end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто
  # увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может 
  # осуществляться только если поезд не движется.
  def vegon_connect_plus
    @quantity += 1 if @speed == 0 
  end

  def vegon_connect_minus
    @quantity -= 1 if @speed == 0 
  end

  # Может принимать маршрут следования (объект класса Route). 
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def route(route)
    @train_route = route
    @train_station = route.show_stations.first
    #puts @train_station
    @train_station.reception(self)
    #@route[0].reception(self)
    #@station = @route.show_first_station.reception(self)
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_station_up
    @train_station.send_train(self)
    @index += 1
    @train_station = @train_route.show_stations[@index]
    @train_station.reception(self)
  end

  def move_station_down
    @train_station.send_train(self)
    @index -= 1
    @train_station = @train_route.show_stations[@index]
    @train_station.reception(self)
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def return_next_station
    @next_train_station = @train_route.show_stations[@index + 1]
    puts "Следующая станция поезда #{@next_train_station.name}"
  end

  def return_station
    @train_station
    puts "Текущая станция поезда #{@train_station.name}"
  end
  
  def return_last_station
    @last_train_station = @train_route.show_stations[@index - 1]
    puts "Предыдущая станция поезда #{@last_train_station.name}"
  end
end


station1 = Station.new('Devyatkino')
station2 = Station.new('Grazdanskya')
station3 = Station.new('Akademichaeskaya')
station4 = Station.new('Politechnicheskaya')
station5 = Station.new('Veteranov')

station6 = Station.new('Rybatskoe')
station7 = Station.new('Obuhovo')
station8 = Station.new('Proletarskaya')
station9 = Station.new('Lomonosovskaya')
station10 = Station.new('Elizarovskaya')

route1 = Route.new(station1, station5)
route1.add_station(station2)
route1.add_station(station3)
route1.add_station(station4)

puts "Route1 #{route1.show_stations}"

route2 = Route.new(station6, station10)
route2.add_station(station7)
route2.add_station(station8)
route2.add_station(station9)

train1 = Train.new(1, 'грузовой', 10)
train2 = Train.new(2, 3, 4)
train3 = Train.new(3, 3, 6)

puts "Номер поезда #{train1.number} тип #{train1.type}"

puts "Задаем скорость поезда 1"
train1.speed=60
puts "Скорость поезда 1 #{train1.speed}"

puts "Задаем скорость поезда 2"
train2.speed=20
puts "#{train2.speed}"

puts "Задаем скорость поезда 3"
train3.speed=40
puts "#{train3.speed}"

puts "Задаем скорость поезда 1 = 0"
train1.stop
puts "#{train1.speed}"

train1.quantity
puts "Кол-во вагонов в поезде №#{train1.number} =  #{train1.quantity}"

train1.vegon_connect_plus
puts "Кол-во вагонов в поезде №#{train1.number} после добавления  =  #{train1.quantity}"

train2.vegon_connect_plus
puts "Кол-во вагонов в поезде №#{train2.number} после добавления на скорости =  #{train2.quantity}"

train1.vegon_connect_minus
puts "Кол-во вагонов в поезде №#{train1.number} после удаления =  #{train1.quantity_vagons}"

station1.reception(train1)
station1.train_list
puts "Поезда на станции #{station1.name} после метода добавления  = #{station1.train_list}"

station1.send_train(train1)
station1.train_list
puts "Поезда на станции удаление поезда с станции#{station1.train_list}"

#puts "До маршрута спсиок поездов на станции #{station1.train_list}"
puts "список станций маршрут 1"
route1.show_stations
puts "список станций маршрут 2"
route2.show_stations

puts "Добавление маршрута к поезду"
train1.route(route1)
puts "Количество поездов на станции №1 после добавления маршрута"
station1.show_trains

puts "Кол-во поездов по типам"
station1.train_list_type

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №1"
station1.show_trains
puts "Количество поездов на станции №2"
station2.show_trains

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №2"
station2.show_trains
puts "Количество поездов на станции №3"
station3.show_trains

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №3"
station3.show_trains
puts "Количество поездов на станции №4"
station4.show_trains

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №4"
station4.show_trains
puts "Количество поездов на станции №5"
station5.show_trains

puts "Движение поезда по маршруту вниз"
train1.move_station_down
puts "Количество поездов на станции №5"
station5.show_trains
puts "Количество поездов на станции №4"
station4.show_trains

puts "Движение поезда по маршруту вниз"
train1.move_station_down
puts "Количество поездов на станции №4"
station4.show_trains
puts "Количество поездов на станции №3"
station3.show_trains

train1.return_station
train1.return_next_station
train1.return_last_station






#puts "После маршрута спсиок поездов на станции #{station1.train_list}"

#train1.move_station_up
#puts "После маршрута спсиок поездов на станции #{station1.train_list}"
