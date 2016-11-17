class Player
  attr_reader :status, :money, :tools, :lands, :currentLand
  attr_writer :status

  def initialize (id, init_money = 1000)
    @id = id
    @status = 'WAIT_FOR_COMMAND'
    @money = init_money
    @tools = []
    @lands = []
    @currentLand = nil
  end

  def execute (command)
    @status = command.execute(self)
  end

  def respond (response)
    @status = response.respond(self)
  end

  def sellTool (toolId)
    @tools.delete(toolId)
  end

  def sellLand (landId)
    @lands.delete_if { |land| land.id == landId }
  end

  def moveTo (land)
    @currentLand = land
  end

  def buyCurrentLand
    if canPay?(@currentLand.price)
      @currentLand.owner = self
      @lands.push(@currentLand)
      @money += @currentLand.price
    end
  end

  def canPay? (price)
    self.money >= price
  end
end