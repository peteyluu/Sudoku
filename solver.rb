require_relative 'board'

class SudokuSolver
  attr_reader :board, :coords

  def self.from_file(filename)
    board = Board.from_file(filename)
  end

  def initialize(filename)
    @board = SudokuSolver.from_file(filename)
    @coords = find_empty_values

    run
  end

  def run
    solve(0)
  end

  def solve(idx)
    # system('clear')
    curr_coord = @coords[idx]

    if board.solved?
      puts "You win!"
      board.render
      return true
    else
      row, col = curr_coord
      (1..9).each do |num|
        if is_safe?(row, col, num)
          @board.update_value_tile(curr_coord, num)
          if solve(idx + 1)
            return true
          else
            @board.update_value_tile(curr_coord, 0)
          end
        end
      end
    end
    false
  end

  def is_safe?(row_i, col_i, num)
    row = []
    (0..8).each do |i|
      row << board.grid[row_i][i].value
    end
    return false if row.include?(num)

    col = []
    (0..8).each do |j|
      col << board.grid[j][col_i].value
    end
    return false if col.include?(num)

    if row_i.between?(0, 2)
      if col_i.between?(0, 2)
        sqs = []
        (0..2).each do |i|
          (0..2).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      elsif col_i.between?(3, 5)
        sqs = []
        (0..2).each do |i|
          (3..5).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      elsif col_i.between?(6, 8)
        sqs = []
        (0..2).each do |i|
          (6..8).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      end
    elsif row_i.between?(3, 5)
      if col_i.between?(0, 2)
        sqs = []
        (3..5).each do |i|
          (0..2).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      elsif col_i.between?(3, 5)
        sqs = []
        (3..5).each do |i|
          (3..5).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      elsif col_i.between?(6, 8)
        sqs = []
        (3..5).each do |i|
          (6..8).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      end
    elsif row_i.between?(6, 8)
      if col_i.between?(0, 2)
        sqs = []
        (6..8).each do |i|
          (0..2).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      elsif col_i.between?(3, 5)
        sqs = []
        (6..8).each do |i|
          (3..5).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      elsif col_i.between?(6, 8)
        sqs = []
        (6..8).each do |i|
          (6..8).each do |j|
            sqs << board.grid[i][j].value
          end
        end
        return false if sqs.include?(num)
      end
    end

    true
  end

  def find_empty_values
    coords = []
    (0..8).each do |row_i|
      (0..8).each do |col_i|
        tile = board.grid[row_i][col_i]
        if tile.given? == false
          coords << [row_i, col_i]
        end
      end
    end
    coords
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Enter filename (ie. sudoku1.txt): "
  input = gets.chomp
  s = SudokuSolver.new(input)
end
