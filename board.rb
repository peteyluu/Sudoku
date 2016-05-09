require_relative 'tile'

class Board
  attr_reader :grid

  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new(0) }
    end
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split('').map { |char| Integer(char) }
      nums.map { |num| Tile.new(num) }
    end

    Board.new(tiles)
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
  end

  def update_value_tile(pos, value)
    row, col = pos
    tile = @grid[row][col]
    tile.value = value
  end

  def render
    header
    (0..8).each do |row_i|
      row = []
      (0..8).each do |col_i|
        row << grid[row_i][col_i].to_s
      end
      puts "#{row_i} #{row.join(" ")}"
    end
  end

  def solved?
    check_rows && check_cols && check_squares
  end

  def check_squares
    h = Hash.new { |h, k| h[k] = [] }

    (0..2).each do |i|
      (0..2).each do |j|
        h[0] << grid[i][j].value
      end
      (3..5).each do |k|
        h[1] << grid[i][k].value
      end
      (6..8).each do |l|
        h[2] << grid[i][l].value
      end
    end

    (3..5).each do |i|
      (0..2).each do |j|
        h[3] << grid[i][j].value
      end
      (3..5).each do |k|
        h[4] << grid[i][k].value
      end
      (6..8).each do |l|
        h[5] << grid[i][l].value
      end
    end

    (6..8).each do |i|
      (0..2).each do |j|
        h[6] << grid[i][j].value
      end
      (3..5).each do |k|
        h[7] << grid[i][k].value
      end
      (6..8).each do |l|
        h[8] << grid[i][l].value
      end
    end

    sub_squares = Array.new(9, 0)
    h.each { |k, v| sub_squares[k] = h[k] }

    sub_squares.each { |square| return false if square.sort != (1..9).to_a }

    true
  end

  def check_cols
    temp_grid = grid.transpose
    9.times do |i|
      col = []
      9.times do |j|
        col << temp_grid[i][j].value
      end
      return false if col.sort != (1..9).to_a
    end
    true
  end

  def check_rows
    9.times do |i|
      row = []
      9.times do |j|
        row << grid[i][j].value
      end
      return false if row.sort != (1..9).to_a
    end
    true
  end

  # def dup
  #   duped_grid = grid.map do |row|
  #     row.map { |tile| Tile.new(tile.value) }
  #   end
  #   Board.new(duped_grid)
  # end

  # def [](row, col)
  #   grid[row][col]
  # end

  # def []=(pos, value)
  #   row, col = pos
  #   tile = @grid[row][col]
  #   tile.value = value
  # end

  def header
    puts "  #{(0..8).to_a.join(" ")}"
  end
end
