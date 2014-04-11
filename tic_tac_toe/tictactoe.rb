require_relative 'tictaccomputer'
require_relative 'tictacview'

class TicTacToe

  def initialize
    @board = ["   ","   ","   ",
              "   ","   ","   ",
              "   ","   ","   "]
    @token = "pc_turn"
    @pc = Computer.new
    @view = TicTacView.new
  end

  def pc_turn
    pc = @pc.assess(@board)
    @board[pc] = " X "
    @token = "player_turn"
    play
  end

  def player_turn
    indices = @view.prompt_player.to_i - 1
    @board[indices] = " O "
    @token = "pc_turn"
    play
  end

  def play
    @view.display_board(@board)
    self.send(@token)
  end

end

TicTacToe.new.play 