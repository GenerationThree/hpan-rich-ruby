require_relative './response'

class BuyLandResponse < Response
  def respond (player)
    player.buyCurrentLand();
    return 'END_TURN'
  end
end