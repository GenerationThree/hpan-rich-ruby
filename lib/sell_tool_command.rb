require_relative './command'

class SellToolCommand < Command
  def initialize (toolId)
    @toolId = toolId
  end

  def execute (player)
    player.sellTool(@toolId)
    return 'WAIT_FOR_COMMAND'
  end
end