module TicTacToe
  class MoveNotAvailableError < StandardError 
  end
    
  class Board    
    attr_reader :squares, :size, :unique_marked_values
    
    def initialize(size = 3)
      @size = size
      reset
    end
    
    def reset
			@squares = Array.new(size**2)
      @unique_marked_values = []      
    end

    def mark(move, value)
      if move_available?(move)
        squares[move] = value
        @unique_marked_values << value if !@unique_marked_values.include?(value)
      else
        raise MoveNotAvailableError
      end
    end
    
    def clear(position)
      squares[position] = nil
    end
    
    def filled?
      available_moves.empty?
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
    
    def available_moves
      result = []
      (0...squares.size).each do |position|
        result << position if move_available?(position)
      end
      result
    end    
    
    private    
		def move_available?(position)
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
			squares[position]
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