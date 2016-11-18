require 'rspec'
require 'rspec'
require_relative '../lib/roll_command'
require_relative '../lib/player'
require_relative '../lib/land'
require_relative '../lib/game_map'
require_relative '../lib/use_tool_command'

describe 'use tool test' do
  before(:each) do
    @player = Player.new 1
    @start = Land.new 0
    @land1 = Land.new 1
    @land2 = Land.new 2
    @land11 = Land.new 11
    @game_map = GameMap.new

    @game_map.lands.push(@start)
    @game_map.lands.push(@land1)
    @game_map.lands.push(@land2)
    for i in 3..10
      @game_map.lands.push(Land.new i)
    end
    @game_map.lands.push(@land11)
    for i in 12..21
      @game_map.lands.push(Land.new i)
    end

    @set_block_command = UseToolCommand.new 1, 2, @game_map
    @set_block_too_far_command = UseToolCommand.new 1, 11, @game_map
    @use_robot_command = UseToolCommand.new 2, -1, @game_map
    @set_bomb_command = UseToolCommand.new 3, 2, @game_map
    @set_bomb_too_far_command = UseToolCommand.new 3, 11, @game_map

    @player.move_to(@start)
  end

  it 'should wait for command after executing set tool command' do
    @player.execute(@set_block_command)

    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should set block on map' do
    @player.execute(@set_block_command)

    expect(@land2.is_blocked).to eq true
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should not set block on player' do
    @player.move_to(@land2)

    @player.execute(@set_block_command)

    expect(@land2.is_blocked).to eq false
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should not set block too far' do

    @player.execute(@set_block_too_far_command)

    expect(@land11.is_blocked).to eq false
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should set bomb on map' do
    @player.execute(@set_bomb_command)

    expect(@land2.is_bombed).to eq true
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should not set bomb on player' do
    @player.move_to(@land2)

    @player.execute(@set_bomb_command)

    expect(@land2.is_bombed).to eq false
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should not set bomb too far' do

    @player.execute(@set_bomb_too_far_command)

    expect(@land11.is_bombed).to eq false
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

  it 'should clear tools on map' do
    @land1.is_blocked = true
    @land2.is_bombed = true

    @player.execute(@use_robot_command)

    expect(@land1.is_blocked).to eq false
    expect(@land2.is_bombed).to eq false
    expect(@player.status).to eq 'WAIT_FOR_COMMAND'
  end

end