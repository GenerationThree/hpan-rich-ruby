require_relative './response'

class NotUpdateLandResponse < Response
  def respond (player)
    return 'END_TURN'
  end
end