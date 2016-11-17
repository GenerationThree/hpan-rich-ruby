require_relative './response'

class UpdateLandResponse < Response
  def respond (player)
    player.updateCurrentLand()
    return 'END_TURN'
  end
end