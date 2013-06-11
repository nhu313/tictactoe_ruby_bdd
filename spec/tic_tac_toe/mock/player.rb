class MockPlayer
  attr_accessor :moves, :name

  def initialize(moves = [])
    @moves = moves
  end

  def add_move(move)
    @moves << move
  end

  def move
    @moves.shift
  end
end
