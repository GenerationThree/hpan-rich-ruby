require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'
require_relative '../lib/not_buy_tool_response'
require_relative '../lib/buy_tool_response'

describe 'roll to prison test' do
  before(:each) do
    @start = Land.new 0
    @prison = Land.new 1
    @prison.is_prison = true
    @game_map = GameMap.new
    @game_map.lands.push(@start)
    @game_map.lands.push(@prison)

    @player = Player.new 1
    @player.move_to(@start)

    @roll_command = RollCommand.new @game_map
    @player.stub(:roll) { 1 }
  end

  it 'should end turn when roll to prison' do
    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @prison
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should stay in prison for two rounds' do
    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @prison

    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @prison
    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @prison

    @player.execute(@roll_command)
    expect(@player.currentLand).to eq @start
  end
end