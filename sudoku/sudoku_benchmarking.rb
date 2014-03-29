# require 'benchmark'

class Sudoku

  def initialize(board_string)
    @board = create_board(board_string.split(//).map {|str| str.to_i})
    @potentials = (0..9).to_a
  end

  def create_board(num_array)
    Array.new(9) {Array.new(3) { num_array.map! {|zero| zero == 0 ? (1..9).to_a : zero }.shift(3) } }
  end

  def solve!
    
    @board.each_with_index do |row, row_indx|
      row.each_with_index do |cell, cell_indx|
        cell.each_with_index do |find_array, void_indx|
          if find_array.class == Array
            rejection_tray = local_values(row_indx, cell_indx, void_indx)
            find_array.reject! { |i| rejection_tray.include?(i) }
            
            @board[row_indx][cell_indx][void_indx] = find_array[0] if find_array.length == 1
          end
        end
      end
    end
    solved?
  end

  def local_values(row, local, column)
    returning_values = []
    @board[row].each{|row| returning_values << row}

    @board.each {|subset| returning_values << [subset[local][column]] }

    @board[local_cluster(row)].each {|cluster| returning_values << cluster[local] }

    returning_values.flatten(1).reject! {|array| array.class == Array}.uniq
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


  def board
    @board.each do |row|
    p  row
    end
  end

end


board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

#puts Benchmark.measure {game.solve!} * 5


game.solve!

game.board