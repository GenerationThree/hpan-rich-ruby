require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'
require_relative '../lib/select_gift_response'

describe 'roll to gift house test' do

  before(:each) do
    @player = Player.new 1
    @gift_house = Land.new 1
    @game_map = GameMap.new
    @roll_command = RollCommand.new @game_map
    @select_money_gift_response = SelectGiftResponse.new 1
    @select_points_gift_response = SelectGiftResponse.new 2
    @select_lucky_gift_response = SelectGiftResponse.new 3

    @gift_house.is_gift_house = true
  end

  it 'should wait for response when roll to gift house' do
    @game_map.stub(:move) { @gift_house }

    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @gift_house
    expect(@player.status).to eq 'WAIT_FOR_RESPONSE'
  end

  it 'should select money as gift on gift house' do
    @game_map.stub(:move) { @gift_house }

    @player.execute(@roll_command)
    @player.respond(@select_money_gift_response)

    expect(@player.currentLand).to eq @gift_house
    expect(@player.money).to eq 1000 + 2000
    expect(@player.status).to eq 'END_TURN'
  end


  it 'should select money as gift on gift house' do
    @game_map.stub(:move) { @gift_house }

    @player.execute(@roll_command)
    @player.respond(@select_money_gift_response)

    expect(@player.money).to eq 1000 + 2000
    expect(@player.status).to eq 'END_TURN'
  end


  it 'should select points as gift on gift house' do
    @game_map.stub(:move) { @gift_house }

    @player.execute(@roll_command)
    @player.respond(@select_points_gift_response)

    expect(@player.points).to eq 200
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should select lucky as gift on gift house' do
    @game_map.stub(:move) { @gift_house }

    @player.execute(@roll_command)
    @player.respond(@select_lucky_gift_response)

    expect(@player.isLucky).to eq true
    expect(@player.lucky_round_left).to eq 5
    expect(@player.status).to eq 'END_TURN'
  end
end