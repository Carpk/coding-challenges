class TicTacView

  def initialize(name)
    print <<-EOS
    Hello, you opponent for this round is #{name}.
    Enter 1-9 to make your placement on the grid, such as below:

       1 | 2 | 3 
      ---|---|---
       4 | 5 | 6
      ---|---|---
       7 | 8 | 9

    Let's begin!  
    EOS
    sleep (3)
  end

  def prompt_player
    puts "Enter 1-9 to choose your placement on grid"
    gets.chomp
  end

  def tie(msg)
    puts msg
  end

  def error(msg)
    puts msg
  end

  def win(msg)
    puts msg
  end

  def display_board(board)
    print "\e[2J"
    print <<-EOS
    #{board[0]}|#{board[1]}|#{board[2]}
    ---|---|---
    #{board[3]}|#{board[4]}|#{board[5]}
    ---|---|---
    #{board[6]}|#{board[7]}|#{board[8]}
    EOS
    sleep (0.5)
  end
end