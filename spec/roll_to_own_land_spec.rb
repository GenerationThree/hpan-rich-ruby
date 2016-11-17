require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'
require_relative '../lib/not_update_land_response'
require_relative '../lib/update_land_response'
require_relative '../lib/buy_land_response'

describe 'roll to own land test' do
  before(:each) do
    @player = Player.new 1
    @land0 = Land.new 0
    @land1 = Land.new 1
    @game_map = GameMap.new
    @roll_command = RollCommand.new @game_map
    @not_update_land_response = NotUpdateLandResponse.new
    @update_land_response = UpdateLandResponse.new

    @player.lands.push(@land1)
    @land1.owner = @player
  end

  it 'should wait for response when roll to own land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    expect(@player.currentLand).to be @land1
    expect(@player.status).to eq 'WAIT_FOR_RESPONSE'
  end

  it 'should able to choose not to update on own land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@not_update_land_response)

    expect(@land1.level).to eq 0
    expect(@player.money).to eq 1000
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should able to choose to update on own land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@update_land_response)

    expect(@land1.level).to eq 1
    expect(@player.money).to eq (1000 - @land1.price)
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should not able to update on own land with level three' do
    @land1.level = 3
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@update_land_response)

    expect(@land1.level).to eq 3
    expect(@player.money).to eq (1000)
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should not able to update on own land with level three' do
    @land1.level = 3
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@update_land_response)

    expect(@land1.level).to eq 3
    expect(@player.money).to eq (1000)
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should not able to update on own land without enough money' do
    @player.money = 100
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    @player.respond(@update_land_response)

    expect(@land1.level).to eq 0
    expect(@player.money).to eq (100)
    expect(@player.status).to eq 'END_TURN'
  end
end