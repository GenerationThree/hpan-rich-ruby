require_relative './command'

class UseToolCommand < Command
  def initialize (toolId, position, gamp_map)
    @tool_id = toolId
    @position = position
    @game_map = gamp_map
  end

  def execute (player)
    if !@game_map.lands[@position].has_player_on?() || @position == -1
      player.set_tool(@tool_id, @game_map.lands[@position], @game_map)
    end
    return 'WAIT_FOR_COMMAND'
  end
end