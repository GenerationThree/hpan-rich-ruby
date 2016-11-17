require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'
require_relative '../lib/not_buy_land_response'
require_relative '../lib/buy_land_response'

describe 'roll to empty land test' do
  before(:each) do
    @player = Player.new 1
    @land0 = Land.new 0
    @land1 = Land.new 1
    @game_map = GameMap.new
    @roll_command = RollCommand.new @game_map
    @not_buy_land_response = NotBuyLandResponse.new
    @buy_land_response = BuyLandResponse.new
  end

  it 'should wait for response when roll to empty land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    expect(@player.currentLand).to be @land1
    expect(@player.status).to eq 'WAIT_FOR_RESPONSE'
  end

  it 'should able to choose not to buy on empty land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@not_buy_land_response)

    expect(@land1.owner).to eq nil
    expect(@player.lands.length).to eq 0
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should able to choose to buy on empty land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@buy_land_response)

    expect(@land1.owner).to eq @player
    expect(@player.lands.length).to eq 1
    expect(@player.money).to eq 1000 + 500
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should not able to buy without enough money on empty land' do
    @game_map.stub(:move) { @land1 }
    @player = Player.new(1, 100)

    @player.execute(@roll_command)

    @player.respond(@buy_land_response)

    expect(@land1.owner).to eq nil
    expect(@player.lands.length).to eq 0
    expect(@player.money).to eq 100
    expect(@player.status).to eq 'END_TURN'
  end
end