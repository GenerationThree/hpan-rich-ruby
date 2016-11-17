class RollCommand
  def initialize (gameMap)
    @gameMap = gameMap
  end

  def execute (player)

    player.moveTo(@gameMap.move(player.currentLand, 1))
    return 'WAIT_FOR_RESPONSE'
  end
end