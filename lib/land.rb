class Land
  attr_reader :id, :owner, :price, :level, :is_gift_house
  attr_writer :owner, :level, :is_gift_house

  def initialize (id, price = 500)
    @id = id
    @price = price
    @level = 0
    @is_gift_house = false
  end

  def levelUp
    @level += 1
  end

  def getPassingFee
    @price / 2 * (2**@level)
  end

end