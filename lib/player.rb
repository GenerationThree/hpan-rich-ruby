class Player
  attr_reader :status, :money, :points, :tools, :lands, :currentLand, :isLucky, :lucky_round_left, :isInPrison, :is_in_hospital, :bye_round_left
  attr_writer :status, :money, :points, :isLucky, :isInPrison, :is_in_hospital, :bye_round_left

  def initialize (id, init_money = 1000)
    @position = id
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
    @is_in_hospital = false
    @bye_round_left = 0
  end

  def execute (command)
    @status = command.execute(self)
  end

  def respond (response)
    @status = response.respond(self)
  end


  def set_tool (tool_id, land, game_map)
    lands_num = game_map.lands.length
    current_position = currentLand.position

    if tool_id == 1 && (land.position - current_position < 10 || (lands_num - (current_position - land.position)) < 10)
      land.is_blocked = true
    end

    if tool_id == 2

      for i in 1..10
        next_land = game_map.lands[(current_position + i) % lands_num]
        next_land.is_bombed = false
        next_land.is_blocked = false
      end
    end

    if tool_id == 3 && (land.position - current_position < 10 || (lands_num - (current_position - land.position)) < 10)
      land.is_bombed = true
    end
  end


  def buy_tool (tool_id)
    if tool_id == 1 || tool_id == 3
      tool_points = 50
    end
    if tool_id == 2
      tool_points = 30
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
    @lands.delete_if { |land| land.position == landId }
  end

  def move_to (land)
    if @lucky_round_left != 0
      @lucky_round_left -= 1
    else
      @isLucky = false
    end

    if @currentLand != nil
      @currentLand.players.delete(self)
    end

    land.players.push(self)
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

  def imprisoned
    @isInPrison = true
    @bye_round_left = 2
  end

  def hospitalised
    @is_in_hospital = true
    @bye_round_left = 3
  end

  def roll

  end
end