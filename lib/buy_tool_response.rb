require_relative './response'

class BuyToolResponse < Response
  def initialize (tool_id)
    @tool_id = tool_id
  end

  def respond(player)
    player.buy_tool(@tool_id)
    return 'END_TURN'
  end
end