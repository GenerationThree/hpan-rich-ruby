require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/tool_house'
require_relative '../lib/game_map'
require_relative '../lib/not_buy_tool_response'
require_relative '../lib/buy_tool_response'

describe 'roll to tool house test' do
  before(:each) do
    @player = Player.new 1
    @tool_house = ToolHouse.new 1
    @game_map = GameMap.new
    @roll_command = RollCommand.new @game_map
    @not_buy_tool_response = NotBuyToolResponse.new
    @buy_tool_one_response = BuyToolResponse.new 1

    @player.points = 100
  end

  it 'should wait for response when roll to tool house' do
    @game_map.stub(:move) { @tool_house }

    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @tool_house
    expect(@player.status).to eq 'WAIT_FOR_RESPONSE'
  end

  it 'should able to choose not to buy tool' do
    @game_map.stub(:move) { @tool_house }

    @player.execute(@roll_command)
    @player.respond(@not_buy_tool_response)

    expect(@player.tools.length).to eq 0
    expect(@player.points).to eq 100
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should able to choose to buy tool' do
    @game_map.stub(:move) { @tool_house }

    @player.execute(@roll_command)
    @player.respond(@buy_tool_one_response)

    expect(@player.tools.length).to eq 1
    expect(@player.points).to eq 100 - 50
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should not able to buy tool without enough points' do
    @player.points = 0
    @game_map.stub(:move) { @tool_house }

    @player.execute(@roll_command)
    @player.respond(@buy_tool_one_response)

    expect(@player.tools.length).to eq 0
    expect(@player.points).to eq 0
    expect(@player.status).to eq 'END_TURN'
  end

  it 'should not able to buy tool without enough points' do
    10.times do
      @player.tools.push(1)
    end
    @game_map.stub(:move) { @tool_house }

    @player.execute(@roll_command)
    @player.respond(@buy_tool_one_response)

    expect(@player.tools.length).to eq 10
    expect(@player.points).to eq 100
    expect(@player.status).to eq 'END_TURN'
  end
end