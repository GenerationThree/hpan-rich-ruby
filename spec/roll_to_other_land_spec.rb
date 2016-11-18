require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'

describe 'roll to others land test' do
  before(:each) do
    @player = Player.new 1
    @player2 = Player.new 2
    @land0 = Land.new 0
    @land1 = Land.new 1
    @game_map = GameMap.new
    @roll_command = RollCommand.new @game_map

    @player2.lands.push(@land1)
    @land1.owner = @player2
  end

  it 'should end turn when roll to others land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    expect(@player.currentLand).to be @land1
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should pay on other player land' do
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    expect(@player.money).to be 1000 - @land1.price / 2
    expect(@player2.money).to be 1000 + @land1.price / 2
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should pay on other player land with level 3' do
    @land1.level = 3
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    expect(@player.money).to be 1000 - @land1.price / 2 * 2 * 2 * 2
    expect(@player2.money).to be 1000 + @land1.price / 2 * 2 * 2 * 2
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should no need to pay on other player land when lucky' do
    @player.become_lucky

    @game_map.stub(:move) { @land1 }
    @player.execute(@roll_command)

    expect(@player.money).to be 1000
    expect(@player2.money).to be 1000
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should no need to pay on other player land when owner in prison' do
    @player2.isInPrison = true
    @game_map.stub(:move) { @land1 }

    @player.execute(@roll_command)

    expect(@player.money).to be 1000
    expect(@player2.money).to be 1000
    expect(@player.status).to eq 'END_TURN'
  end
end