require_relative './command'

class SellToolCommand < Command
  def initialize (toolId)
    @tool_id = toolId
  end

  def execute (player)
    player.sell_tool(@tool_id)
    return 'WAIT_FOR_COMMAND'
  end
end