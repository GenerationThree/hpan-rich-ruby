require_relative './response'

class BuyLandResponse < Response
  def respond (player)
    player.buy_current_land();
    return 'END_TURN'
  end
end