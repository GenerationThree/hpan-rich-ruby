require_relative './command'

class SellLandCommand < Command
  def initialize (landId)
    @landId = landId
  end

  def execute (player)
    player.sellLand(@landId)
    return 'WAIT_FOR_COMMAND'
  end
end