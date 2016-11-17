class Player
  attr_reader :status, :money, :tools, :lands, :currentLand, :isLucky, :isInPrison
  attr_writer :status, :money, :isLucky, :isInPrison

  def initialize (id, init_money = 1000)
    @id = id
    @status = 'WAIT_FOR_COMMAND'
    @money = init_money
    @tools = []
    @lands = []
    @currentLand = nil
    @isLucky = false
    @isInPrison = false
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
      self.earn(@currentLand.price)
    end
  end

  def updateCurrentLand
    if @currentLand.level != 3 && self.money >= @currentLand.price
      @currentLand.levelUp()
      self.pay(@currentLand.price)
    end
  end

  def payPassingFee
    passingFee = @currentLand.getPassingFee()
    landOwner = @currentLand.owner

    if !@isLucky && !landOwner.isInPrison
      self.pay(passingFee)
      landOwner.earn(passingFee)
    end
  end

  def pay (price)
    self.money -= price
  end

  def earn (price)
    self.money += price
  end

  def canPay? (price)
    self.money >= price
  end
end