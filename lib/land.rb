class Land
  attr_reader :id, :owner, :price
  attr_writer :owner

  def initialize (id, price = 500)
    @id = id
    @price = price
  end
end