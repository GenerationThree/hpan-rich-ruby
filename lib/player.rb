class Player
  attr_reader :status, :tools
  attr_writer :status

  def initialize (id)
    @id = id
    @status = 'WAIT_FOR_COMMAND'
    @tools = []
  end

  def execute (command)
    @status = command.execute(self)
  end

  def respond (response)
    @status = response.respond(self)
  end
end