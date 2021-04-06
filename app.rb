class Route
  # Имеет начальную и конечную станцию, а также список промежуточных станций. 
  # Начальная и конечная станции указываютсся при создании маршрута, 
  # а промежуточные могут добавляться между ними.
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
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
  attr_reader :name, :trains
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

  # Может возвращать список поездов на станции по типу (см. ниже): 
  # кол-во грузовых, пассажирских
  def train_list_type(type)
    @trains.filter{|train| train.type == type}
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

    @type = type if (type == 'грузовой') || (type == 'пассажирский')
  end

  def stop
    @speed = 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто
  # увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может 
  # осуществляться только если поезд не движется.
  def wagon_connect_plus
    @quantity += 1 if @speed == 0 
  end

  def wagon_connect_minus
    @quantity -= 1 if @speed == 0 
  end

  # Может принимать маршрут следования (объект класса Route). 
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def route(route)
    @index = 0
    @train_route = route.show_stations
    station.reception(self)
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_station_up
    station.send_train(self)
    @index += 1
    station.reception(self)
  end

  def move_station_down
    station.send_train(self)
    @index -= 1
    station.reception(self)
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def next_station
    if @index + 1 ==  @train_route.length
      puts "End"
    else
      @next_train_station = @train_route[@index + 1]
    end
  end

  def station
    @train_route[@index]
  end
  
  def last_station
    if @index == 0 
      puts "Конечной станции нет"
    else 
      @last_train_station = @train_route[@index - 1]
    end
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

train1.wagon_connect_plus
puts "Кол-во вагонов в поезде №#{train1.number} после добавления  =  #{train1.quantity}"

train2.wagon_connect_plus
puts "Кол-во вагонов в поезде №#{train2.number} после добавления на скорости =  #{train2.quantity}"

train1.wagon_connect_minus
puts "Кол-во вагонов в поезде №#{train1.number} после удаления =  #{train1.quantity}"

station1.reception(train1)
station1.trains
puts "Поезда на станции #{station1.name} после метода добавления  = #{station1.trains}"

station1.send_train(train1)
station1.trains
puts "Поезда на станции удаление поезда с станции#{station1.trains}"

#puts "До маршрута спсиок поездов на станции #{station1.trains}"
puts "список станций маршрут 1"
route1.show_stations
puts "список станций маршрут 2"
route2.show_stations

puts "Добавление маршрута к поезду"
train1.route(route1)
puts "Количество поездов на станции №1 после добавления маршрута"
station1.trains

puts "Кол-во поездов по типам"
station1.train_list_type('грузовой')

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №1"
station1.trains
puts "Количество поездов на станции №2"
station2.trains

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №2"
station2.trains
puts "Количество поездов на станции №3"
station3.trains

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №3"
station3.trains
puts "Количество поездов на станции №4"
station4.trains

puts "Движение поезда по маршруту вверх"
train1.move_station_up
puts "Количество поездов на станции №4"
station4.trains
puts "Количество поездов на станции №5"
station5.trains

puts "Движение поезда по маршруту вниз"
train1.move_station_down
puts "Количество поездов на станции №5"
station5.trains
puts "Количество поездов на станции №4"
station4.trains

puts "Движение поезда по маршруту вниз"
train1.move_station_down
puts "Количество поездов на станции №4"
station4.trains
puts "Количество поездов на станции №3"
station3.trains

train1.station
train1.next_station
train1.last_station

train2.route(route1)

train3.route(route1)
train3.move_station_up
train3.move_station_up
train3.move_station_up
train3.move_station_up
train3.next_station

#puts "После маршрута спсиок поездов на станции #{station1.trains}"

#train1.move_station_up
#puts "После маршрута спсиок поездов на станции #{station1.trains}"
