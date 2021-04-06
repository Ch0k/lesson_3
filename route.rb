class Route
  # Имеет начальную и конечную станцию, а также список промежуточных станций. 
  # Начальная и конечная станции указываютсся при создании маршрута, 
  # а промежуточные могут добавляться между ними.
  def initialize(first_station, last_station)
    @first_station = 'first_station'
    @last_station = 'last_station'
    @stations = []
  end

  # Может добавлять промежуточную станцию в список
  def add_station(station)
    @stations << station
  end

  # Может удалять промежуточную станцию из списка
  def del_station(station)
    @stations.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def show_station
    @stations.each{|station| puts station}
  end
  
end