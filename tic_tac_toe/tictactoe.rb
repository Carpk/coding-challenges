require_relative 'tictaccomputer'
require_relative 'tictacview'

class TicTacToe

  def initialize
    @board = ["   ","   ","   ",
              "   ","   ","   ",
              "   ","   ","   "]
    @token = "pc_turn"
    @pc = Computer.new
    @view = TicTacView.new@pc.persona[:name]
  end

  def pc_turn
    pc = @pc.assess(@board)
    @board[pc] = " X "
    @token = "player_turn"
    play
  end

  def player_turn
    indices = @view.prompt_player.to_i - 1
    if @board[indices] == "   "
      @board[indices] = " O "
      @token = "pc_turn"
      play
    else
      @view.error(@pc.persona[:error])
      player_turn
    end
  end

  def play
    @view.display_board(@board)
    if @pc.win?
      @view.win(@pc.persona[:win])
    elsif @board.include?("   ") == false
      @view.tie(@pc.persona[:tie])
    else
      self.send(@token)
    end
  end
end

TicTacToe.new.play 