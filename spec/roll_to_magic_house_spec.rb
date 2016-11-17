require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'

describe 'roll to magic house test' do
  before(:each) do
    @player = Player.new 1
    @magic_house = Land.new 1
    @roll_command = RollCommand.new @game_map

    @magic_house.is_magic_house = true
  end


  it 'should should end turn when roll to magic house' do
    @game_map.stub(:move) { @magic_house }

    @player.execute(@roll_command)

    expect(@player.currentLand).to eq @magic_house
    expect(@player.status).to eq 'END_TURN'
  end
end