module TicTacToe
  class Board    
    attr_reader :squares, :size
    
    def initialize(size = 3)
      @size = size
      @squares = (0...@size**2).to_a
    end

    def mark(move, value)
      squares[move] = value
    end
    
    def clear
      reset_squares
    end
    
    def filled?
      (0...squares.size).each do |position|
        return false if square_available?(position)
      end
      return true
    end
    
    def rows
      (0...size).inject([]) do |result, row|
        result << squares[row*size, size]
      end
    end
    
    def columns
      result = []
      (0...size).each do |col|
        result << squares.values_at(* squares.each_index.select do |i| 
          (col - i) % 3 == 0
        end)  
      end
      result
    end
    
    def diagonals
      left_diagonal = diagonal_from_top_left
      right_diagonal = diagonal_from_top_right
      [left_diagonal, right_diagonal]
    end
    
    private
    def reset_squares
			@squares = (0...size**2).to_a
    end
    
		def square_available?(position)
			return false if out_of_range?(position)
			return false if marked?(position)

			true
		end
        
		def out_of_range?(position)
			return true if position < 0
			return true if position >= squares.size
			return false
		end

		def marked?(position)
			squares[position].is_a? String
		end
    
    def diagonal_from_top_right
      result = squares.values_at(*squares.each_index.select do |i| 
        i % (size - 1) == 0
      end)
      result[1, size]
    end
    
    def diagonal_from_top_left
      squares.values_at(*squares.each_index.select {|i| i % (size + 1) == 0}) 
    end
  end
end