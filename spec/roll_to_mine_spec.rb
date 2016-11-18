require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'
require_relative '../lib/not_buy_tool_response'
require_relative '../lib/buy_tool_response'

describe 'roll to tool house test' do
  before(:each) do
    @player = Player.new 1
    @mine = Land.new 1
    @game_map = GameMap.new
    @roll_command = RollCommand.new @game_map

    @mine.is_mine = true
    @mine.mine_points = 20
    @player.points = 100
  end

  it 'should end turn when roll to tool house' do
    @game_map.stub(:move) { @mine }

    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @mine
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should earn points on mine' do
    @game_map.stub(:move) { @mine }

    @player.execute(@roll_command)

    expect(@player.points).to eq 100 + 20
    expect(@player.status).to eq 'END_TURN'
  end
end