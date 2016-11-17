require_relative './response'

class UpdateLandResponse < Response
  def respond (player)
    player.update_current_land()
    return 'END_TURN'
  end
end