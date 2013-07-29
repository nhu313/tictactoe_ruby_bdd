module TicTacToe
  VALUES = ["X", "O"]

  class Values
    def self.opponent(value)
      return VALUES[1] if value == VALUES[0]
      VALUES[0]
    end
  end
end
