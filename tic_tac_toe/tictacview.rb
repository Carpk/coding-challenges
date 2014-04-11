class TicTacView


  def prompt_player
    puts "Enter 1-9 to choose your placement on grid"
    gets.chomp
  end

  def display_board(board)
    puts
    puts
    print <<-EOS
    #{board[0]}|#{board[1]}|#{board[2]}
    ---|---|---
    #{board[3]}|#{board[4]}|#{board[5]}
    ---|---|---
    #{board[6]}|#{board[7]}|#{board[8]}
    EOS
  end
end