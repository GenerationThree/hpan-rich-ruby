require_relative './response'

class NotBuyLandResponse < Response
  def respond (player)
    return 'END_TURN'
  end
end