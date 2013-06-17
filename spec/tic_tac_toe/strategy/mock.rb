class MockStrategy
  attr_accessor :moves

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
