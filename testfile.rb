size = 9
squares = (0...size).to_a
# result = (0...9).inject([]) do |result, value| 
#   result << value if value % (size + 1) == 0
#   result
# end

# result = []
# index = 0
# result << index && index += 4 while index < size

# result = [1, 2, 3, 4, 5, 6].inject([]) do |result, elm|
#   result << elm * 2 if elm % 2 == 0
#   # result
# end

# result = []
# diagonal_square_distance = size - 1
# index = diagonal_square_distance
# while result.size < size
#   result << squares[index]
#   index += diagonal_square_distance
# end
# result

# result = squares.values_at(*squares.each_index.select {|i| i % 4 == 0}) 

# result = []
# diagonal_square_distance = 2
# index = diagonal_square_distance
# while result.size < 3
#   result << squares[index]
#   index += diagonal_square_distance
# end

result = squares.values_at(*squares.each_index.select {|i| i % 2 == 0})

puts(result)