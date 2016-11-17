require_relative './response'

class SelectGiftResponse < Response
  def initialize (gift_id)
    @gift_id = gift_id
  end

  def respond (player)
    player.get_gift(@gift_id);
    return 'END_TURN'
  end
end