require_relative './command'

class SellToolCommand < Command
  def initialize (toolId)
    @toolId = toolId
  end

  def execute (player)
    player.tools.delete(@toolId)
    return 'WAIT_FOR_COMMAND'
  end
end