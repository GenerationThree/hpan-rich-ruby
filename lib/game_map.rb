class GameMap
  attr_reader :lands
  attr_writer :lands

  def initialize
    @lands = []
  end

  def move (currentLand, step)
    current_position = currentLand.position

    for i in 1..step
      next_land = @lands[(current_position + i) % @lands.length]

      if next_land.is_blocked
        next_land.is_blocked = false
        return next_land
      end

      if next_land.is_bombed
        next_land.is_bombed = false
        return find_hospital()
      end
    end

    return @lands[(currentLand.position + step) % @lands.length]
  end

  def find_hospital
    @lands.each do |land|
      if land.is_hospital
        return land
      end
    end
  end
end