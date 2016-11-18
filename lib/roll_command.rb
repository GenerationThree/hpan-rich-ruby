require_relative '../lib/tool_house'

class RollCommand
  def initialize (gameMap)
    @gameMap = gameMap
  end

  def execute (player)
    if (player.isInPrison || player.is_in_hospital) && player.bye_round_left > 0
      player.bye_round_left -= 1
    else
      player.move_to(@gameMap.move(player.currentLand, player.roll()))
    end

    if player.currentLand.instance_of? ToolHouse
      return 'WAIT_FOR_RESPONSE'
    end

    if player.currentLand.is_gift_house == true
      return 'WAIT_FOR_RESPONSE'
    end

    if player.currentLand.is_magic_house == true
      return 'END_TURN'
    end

    if player.currentLand.is_hospital == true
      if !player.is_in_hospital
        player.hospitalised()
      end
      return 'END_TURN'
    end

    if player.currentLand.is_prison == true
      if !player.isInPrison
        player.imprisoned()
      end
      return 'END_TURN'
    end

    if player.currentLand.is_mine == true
      player.earn_points(player.currentLand.mine_points)
      return 'END_TURN'
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