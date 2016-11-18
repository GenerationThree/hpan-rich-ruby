class ToolHouse
  attr_reader :position, :players
  attr_writer :players

  def initialize (position)
    @position = position
    @players = []
  end
end