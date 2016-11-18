class Land
  attr_reader :position, :owner, :price, :level, :is_gift_house, :is_magic_house, :is_prison, :is_mine, :mine_points
  attr_writer :owner, :level, :is_gift_house, :is_magic_house, :is_prison, :is_mine, :mine_points

  def initialize (position, price = 500)
    @position = position
    @price = price
    @level = 0
    @is_gift_house = false
    @is_magic_house = false
    @is_prison = false
    @is_mine = false
    @mine_points = 0

  end

  def levelUp
    @level += 1
  end

  def getPassingFee
    @price / 2 * (2**@level)
  end

end