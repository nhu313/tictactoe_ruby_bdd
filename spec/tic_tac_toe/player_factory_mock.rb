class PlayerFactoryMock

  def human(name = "User", value = "X")
    "Human"
  end

  def computer(board, value = "O", opponent_value = "X")
    "Computer"
  end
end
