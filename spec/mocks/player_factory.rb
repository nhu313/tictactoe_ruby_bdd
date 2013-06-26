require 'surrogate/rspec'

class MockPlayerFactory
  Surrogate.endow(self)

  define(:human) {|name = "Sue", value = "X"|}
  define(:computer) {|board, value = "X", opponent="O"|}
end
