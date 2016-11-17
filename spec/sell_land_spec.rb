require 'rspec'
require_relative '../lib/player'
require_relative '../lib/sell_land_command'
require_relative '../lib/land'

describe 'sell land test' do
  before(:each) do
    @player = Player.new 1
    @sellLandCommand = SellLandCommand.new 1
    @land = Land.new 1
    @land2 = Land.new 2
  end

  it 'should wait for command after executing sell land command' do
    @player.execute(@sellLandCommand)

    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should sell land when having it' do
    @player.lands.push(@land)

    @player.execute(@sellLandCommand)

    expect(@player.lands.length).to eq 0
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should not sell land when not having it' do
    @player.lands.push(@land2)

    @player.execute(@sellLandCommand)

    expect(@player.lands.length).to eq 1
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end
end