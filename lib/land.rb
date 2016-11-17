class Land
  attr_reader :id, :owner, :price, :level
  attr_writer :owner, :level

  def initialize (id, price = 500)
    @id = id
    @price = price
    @level = 0
  end

  def levelUp
    @level += 1
  end
end