require 'rspec'
require_relative '../lib/player'
require_relative '../lib/command'
require_relative '../lib/response'

describe 'player status test' do
  before(:each) do
    @player = Player.new 1
    @command = Command.new
    @response = Response.new
  end

  it 'should should wait for response after executing resp requesting command' do
    def @command.execute (player)
      return 'WAIT_FOR_RESPONSE'
    end

    @player.execute(@command)

    expect(@player.status).to eq 'WAIT_FOR_RESPONSE'
  end

  it 'should end turn after executing non resp requesting command' do
    def @command.execute (player)
      return 'END_TURN'
    end

    @player.execute(@command)

    expect(@player.status).to eq 'END_TURN'
  end

  it 'should end turn after responding rolling command' do
    def @response.respond (player)
      return 'END_TURN'
    end

    @player.status = 'WAIT_FOR_RESPONSE'
    @player.respond(@response)

    expect(@player.status).to eq 'END_TURN'
  end

  it 'should wait for command after responding command other than rolling' do
    def @response.respond (player)
      return 'WAIT_FOR_COMMAND'
    end

    @player.respond(@response)

    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end
end