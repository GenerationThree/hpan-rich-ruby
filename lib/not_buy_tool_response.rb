require_relative './response'

class NotBuyToolResponse < Response
  def respond(player)
    return 'END_TURN'
  end
end