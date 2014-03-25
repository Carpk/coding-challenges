require_relative 'battleview'
require_relative 'battlemodel'

class Battleship

  CONVERT = {
             "A" => 0,
             "B" => 1,
             "C" => 2,
             "D" => 3,
             "E" => 4,
             "F" => 5,
             "G" => 6,
             "H" => 7,
             "I" => 8,
             "J" => 9
            }


  def initialize
    @game_over = false
    @viewer = BattleView.new
    @human = BattleModel.new
    @enemy  = BattleModel.new
    @player = @enemy
  end

  def alternate_player
    if @player == @human
      @player = @enemy    
    else
      @player = @human
    end
  end

  def start_game
    while @game_over == false
      alternate_player
      @viewer.launch_prompt
      target = gets.chomp
      escape_keys(target)
      @cords = [[CONVERT[target[0].upcase]],[target[1].to_i]].flatten
      location = @player.board[@cords[0]][@cords[1]]
      incoming_target(location)
    end
  end

  def incoming_target(location)
    case location
    when "o"
      @viewer.open_water
      @player.board[@cords[0]][@cords[1]] = "/"
    when "/", "X"
      @viewer.repeated_bomb
    when "A"
      land_hit("Aircraft carrier")
    when "B"
      land_hit("Battleship")
    when "C"
      land_hit("Crusier")
    when "D"
      land_hit("Destroyer")
    when "S"
      land_hit("Submarine")
    else
      "Not a legible command"
    end
  end

  def land_hit(vessel)
    @player.board[@cords[0]][@cords[1]] = "X"
    @player.ship_integrity[vessel] -= 1
    if @player.ship_integrity[vessel] == 0
      @viewer.vessel_sink(vessel)
    else
      @viewer.vessel_hit(vessel)
    end
  end

  def escape_keys(key)
    case key
    when 'z'
      print @player.board
      start_game
    end
  end

end



game = Battleship.new
game.start_game


=begin
hashes are getting out of hand, I can make arrays to hold names, hits, and non-hits.
=end

