require_relative '../lib/tool_house'

class RollCommand
  def initialize (gameMap)
    @gameMap = gameMap
  end

  def execute (player)
    player.move_to(@gameMap.move(player.currentLand, 1))

    if player.currentLand.instance_of? ToolHouse
      return 'WAIT_FOR_RESPONSE'
    end

    if player.currentLand.is_gift_house == true
      return 'WAIT_FOR_RESPONSE'
    end

    if player.currentLand.owner == nil || player.currentLand.owner == player
      return 'WAIT_FOR_RESPONSE'
    end

    if player.currentLand.owner != player
      player.pay_passing_fee()
      return 'END_TURN'
    end

  end
end