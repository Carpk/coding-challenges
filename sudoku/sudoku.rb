class Sudoku

  def initialize(board_string)
    @board = create_board(board_string.split(//).map {|str| str.to_i})
    @potentials = (0..9).to_a
  end

  def create_board(num_array)
    Array.new(9) {Array.new(3) { num_array.shift(3) } }    # This wasnt working in a single line, find out why!
  end

  def solve!
    @board.each_with_index do |row, row_indx|
      row.each_with_index do |cell, cell_indx|
        cell.each_with_index do |find_empty, void_indx|
          if find_empty == 0
            possibilities = @potentials.reject { |i| local_values(row_indx, cell_indx, void_indx).include?(i) } # output should remove any matching pairs with addition to base base
            p "row: #{row_indx}, column: #{cell_indx}, cell: #{void_indx}, axis values:#{possibilities}"
            if possibilities.length == 1
              @board[row_indx][cell_indx][void_indx] = possibilities[0]
            end
          end
        end
      end
    end
    solved?
  end

  def local_values(row, local, column)
    returning_values = []
    returning_values << @board[row]

    @board.each do |subset|
      returning_values << subset[local][column]
    end

    @board[local_cluster(row)].each do |cluster|
      returning_values << cluster[local]
    end
    returning_values.flatten.uniq
  end

  def local_cluster(position)
    case position
    when 0..2
      0..2
    when 3..5
      3..5
    when 6..9
      6..9
    end
  end

  def solved?
    if @board.flatten.include?(0)
      solve!
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @board.each do |row|
      p row
    end
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"

game.solve!

game.board