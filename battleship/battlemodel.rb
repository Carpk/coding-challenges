class BattleModel
  attr_accessor :board, :ship_integrity

  def initialize
    create_board
  end

  def create_board

    @ship_integrity = {"Aircraft carrier" => 5,
                       "Battleship" => 4,
                       "Crusier" => 3,
                       "Destroyer" => 2,
                       "Submarine" => 1}

    @board = [["B","B","B","B","o","o","o","o","o","o"],
             ["o","S","o","o","o","o","o","o","o","o"],
             ["o","S","o","o","o","o","o","o","o","o"],
             ["o","S","o","o","o","o","o","o","o","o"],
             ["o","o","o","o","o","o","o","o","o","o"],
             ["o","o","o","o","o","o","o","o","o","o"],
             ["o","o","o","o","o","o","o","o","o","o"],
             ["o","o","o","o","o","o","o","o","o","o"],
             ["o","o","o","o","o","o","o","o","o","o"],
             ["o","o","o","o","o","o","o","o","o","o"]]
  end

end
