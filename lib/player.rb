class Player
  attr_reader :status, :money, :points, :tools, :lands, :currentLand, :isLucky, :lucky_round_left, :isInPrison
  attr_writer :status, :money, :points, :isLucky, :isInPrison

  def initialize (id, init_money = 1000)
    @id = id
    @status = 'WAIT_FOR_COMMAND'
    @money = init_money
    @points = 0
    @tools = []
    @max_tool_num = 10
    @lands = []
    @currentLand = nil
    @isLucky = false
    @lucky_round_left = 0
    @isInPrison = false
  end

  def execute (command)
    @status = command.execute(self)
  end

  def respond (response)
    @status = response.respond(self)
  end

  def buy_tool (tool_id)
    if tool_id == 1 || tool_id == 3
      tool_points = 50
    end
    if tool_id == 2
      tool_points = 50
    end

    if self.can_pay_points?(tool_points) && !self.is_tool_bag_full?()
      @tools.push(tool_id)
      self.pay_points(tool_points)
    end
  end

  def sell_tool (tool_id)
    @tools.delete(tool_id)
    if tool_id == 1 || tool_id == 3
      self.earn_points(50)
    end
    if tool_id == 2
      self.earn_points(30)
    end

  end

  def sell_land (landId)
    @lands.delete_if { |land| land.id == landId }
  end

  def move_to (land)
    if @lucky_round_left != 0
      @lucky_round_left -= 1
    else
      @isLucky = false
    end

    @currentLand = land
  end

  def buy_current_land
    if can_pay?(@currentLand.price)
      @currentLand.owner = self
      @lands.push(@currentLand)
      self.earn(@currentLand.price)
    end
  end

  def update_current_land
    if @currentLand.level != 3 && self.money >= @currentLand.price
      @currentLand.levelUp()
      self.pay(@currentLand.price)
    end
  end

  def pay_passing_fee
    passingFee = @currentLand.getPassingFee()
    landOwner = @currentLand.owner

    if !@isLucky && !landOwner.isInPrison
      self.pay(passingFee)
      landOwner.earn(passingFee)
    end
  end

  def pay (price)
    @money -= price
  end

  def pay_points (points)
    @points -= points
  end

  def earn (price)
    @money += price
  end

  def earn_points (points)
    @points += points
  end

  def can_pay? (price)
    @money >= price
  end

  def can_pay_points? (points)
    @points >= points
  end

  def is_tool_bag_full?
    @tools.length == @max_tool_num
  end

  def get_gift (gift_id)
    if gift_id == 1
      self.earn(2000)
    end
    if gift_id == 2
      self.earn_points(200)
    end
    if gift_id == 3
      self.become_lucky()
    end
  end

  def become_lucky
    @isLucky = true
    @lucky_round_left = 5
  end
end