class RollCommand
  def initialize (gameMap)
    @gameMap = gameMap
  end

  def execute (player)
    player.moveTo(@gameMap.move(player.currentLand, 1))

    if player.currentLand.owner == nil || player.currentLand.owner == player
      return 'WAIT_FOR_RESPONSE'
    end

  end
end