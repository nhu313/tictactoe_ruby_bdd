class MockDynamicStrategy
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

  def needs_input?
    true
  end
end
