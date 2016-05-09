require_relative 'board'

class SudokuGame
  attr_reader :board

  def self.from_file(filename)
    board = Board.from_file(filename)
  end

  def initialize(filename)
    @board = SudokuGame.from_file(filename)

    play
  end

  def play
    puts "Welcome to the Sudoku Game!"
    until board.solved?
      system('clear')
      board.render
      pos_val = prompt
      board.update_value_tile(pos_val.first, pos_val.last)
      sleep(2)
    end
    puts "You win!"
  end

  def prompt
    input_pos = get_input_pos
    until valid_pos_input?(input_pos)
      input_pos = get_input_pos
    end

    input_val = get_input_value
    until valid_value_input?(input_val)
      input_val = get_input_value
    end

    [input_pos, input_val]
  end

  def get_input_pos
    print "Enter position (i.e. 0,0): "
    input = gets.chomp.split(',')
    input = [input.first.to_i, input.last.to_i]
  end

  def valid_pos_input?(pos)
    x, y = pos
    x.between?(0, 9) && y.between?(0, 9)
  end

  def get_input_value
    print "Enter value (i.e. 1): "
    input = gets.chomp.to_i
  end

  def valid_value_input?(value)
    value.between?(1, 9)
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Enter filename (ie. sudoku1.txt): "
  input = gets.chomp
  g = SudokuGame.new(input)
end
