require 'rspec'
require_relative '../lib/player'
require_relative '../lib/sell_tool_command'

describe 'sell tool test' do
  before(:each) do
    @player = Player.new 1
    @sellToolOneCommand = SellToolCommand.new 1
  end

  it 'should wait for command after executing sell tool command' do
    @player.execute(@sellToolOneCommand)

    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should sell tool when having it' do
    @player.execute(@sellToolOneCommand)
    @player.tools.push(1)

    @player.execute(@sellToolOneCommand)

    expect(@player.tools.length).to eq 0
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should not sell tool when not having it' do
    @player.execute(@sellToolOneCommand)
    @player.tools.push(2)

    @player.execute(@sellToolOneCommand)

    expect(@player.tools.length).to eq 1
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end
end