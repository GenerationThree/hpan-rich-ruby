class GameMap
  attr_reader :lands
  attr_writer :lands

  def initialize
    @lands = []
  end

  def move (currentLand, step)
    return @lands[(currentLand.position + step) % @lands.length]
  end
end