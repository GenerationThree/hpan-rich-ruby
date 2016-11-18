require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'

describe 'roll to prison test' do
  before(:each) do
    @start = Land.new 0
    @land1 = Land.new 1
    @land2 = Land.new 2
    @land3 = Land.new 3
    @hospital = Land.new 4
    @hospital.is_hospital = true
    @game_map = GameMap.new
    @game_map.lands.push(@start)
    @game_map.lands.push(@land1)
    @game_map.lands.push(@land2)
    @game_map.lands.push(@land3)
    @game_map.lands.push(@hospital)

    @player = Player.new 1
    @player.move_to(@start)

    @roll_command = RollCommand.new @game_map
  end

  it 'should stay at block when triggering block' do
    @land2.is_blocked = true

    @player.stub(:roll) { 3 }

    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @land2
    expect(@land2.is_blocked).to eq false
  end

  it 'should sent to hospital when triggering bomb' do
    @land2.is_bombed = true
    @player.stub(:roll) { 3 }

    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @hospital
    expect(@land2.is_bombed).to eq false
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should stay at hospital for three rounds' do
    @land2.is_bombed = true
    @player.stub(:roll) { 3 }

    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @hospital

    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @hospital
    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @hospital
    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @hospital

    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @land2

  end
end