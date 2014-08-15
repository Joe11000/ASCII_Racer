# race car application
# input : array of racer names
# output: no valuable output (besides pretty race and congradulatory comments to winner)

require_relative 'racer_utils'
require 'pry'

class RubyRacer
  attr_reader :players, :length

  def initialize(players=[a,b], length=30)
    @players = players
    @player_colors = ["\033[92m","\033[91m","\033[96m", "\033[94m","\033[95m", "\033[93m"] # green, red, light-blue, blue, pink, yellow
    @length = length
    @die = Die.new
    @racers_hash = {}
    players.each {|player| @racers_hash[player] = 1 }
  end

  # Returns +true+ if one of the players has reached
  # the finish line, +false+ otherwise
  def finished?(player)
    @racers_hash[player] >= length-1
  end

  # Rolls the dice and advances +player+ accordingly
  def advance_player!(player)
    single_roll = @die.roll # save new dice roll

    @racers_hash[player] += single_roll
  end

  def determine_winners
    winner_so_far = @players.first
    winners = []
    # binding.pry
    @players.each do |p|
      if @racers_hash[winner_so_far] < @racers_hash[p]
        winner_so_far = p
        winners = [p]
      elsif if @racers_hash[winner_so_far] == @racers_hash[p]
        winners << p
      end

      end
    end

    winners
  end

  # Prints the current game board
  # The board should have the same dimensions each time
  # and you should use the "reputs" helper to print over
  # the previous board
  def print_board
    color_end = "\033[0m"
    loop_counter = 0
    @players.each do |p|
      print " | " * (@racers_hash[p] - 1) + @player_colors[loop_counter % @player_colors.size]
      print " #{@players[loop_counter][0]} "
      print color_end
      print  " | " * (@length - (@racers_hash[p] < length-1 ? @racers_hash[p] : length-1)  - 1)
      loop_counter += 1
      puts
    end
  end
end

def startRace(names_array, length)
  game = RubyRacer.new(names_array, length)

  clear_screen! # This clears the screen, so the fun can begin

  move_to_home! # This moves the cursor back to the upper-left of the screen
  game.print_board # put starting screen

  somebody_finished = false

  until somebody_finished do

    names_array.each do |player|
      move_to_home! # This moves the cursor back to the upper-left of the screen
      game.advance_player!(player) # We print the board first so we see the initial, starting board
      game.print_board

      if game.finished?(player)
        somebody_finished = true
      end

      names_array.size >= 10 ? sleep(0.05) : sleep(0.1) # if number if racers is > 10 then sleep less time
    end
  end

  result = game.determine_winners
  if result.length == 1
    puts "#{result.first} Won!!!!"
  else
    puts "#{result.join(', ')} TIED!!!!"
  end

  puts "*Slap on the butt.* Thanks for playing."
end


racers = ('a'..'g').to_a
startRace(racers, 60)
