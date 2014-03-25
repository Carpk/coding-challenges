# require 'benchmark'

class Sudoku

  def initialize(board_string)
    @board = create_board(board_string.split(//).map {|str| str.to_i})
    @potentials = (0..9).to_a
  end

  def create_board(num_array)
    # num_array.map! {|zero| zero == 0 ? (1..9).to_a : zero }shift(3)
    Array.new(9) {Array.new(3) { num_array.map! {|zero| zero == 0 ? (1..9).to_a : zero }.shift(3) } }
  end

  def solve!
    @board.each_with_index do |row, row_indx|
      row.each_with_index do |cell, cell_indx|
        cell.each_with_index do |find_array, void_indx|
          if find_array.class == Array
            find_array.reject! { |i| local_values(row_indx, cell_indx, void_indx).include?(i) }
            p "row: #{row_indx}, column: #{cell_indx}, cell: #{void_indx}, axis values:#{find_array}"
            if find_array.length == 1
              @board[row_indx][cell_indx][void_indx] = find_array[0]
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
    returning_values.reject! {|array| array.class == Array}.flatten.uniq
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
    @board.flatten(2).each{|i| solve! if i.class == Array}
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    p @board.flatten(2) #.each do |row|
    # p  row
    # end
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

#puts Benchmark.measure {game.solve!} * 5

# Remember: this will just fill out what it can and not "guess"

game.solve!

game.board