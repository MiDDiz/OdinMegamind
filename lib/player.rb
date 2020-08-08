class Player
  attr_accessor :points, :guessing
  attr_reader :name
  def initialize(name, interface, game_board)
    @name = name
    @points = 0
    @interface = interface
    @game_board = game_board
  end

  def new_code_input
    interface.ask_for_input
  end

  private

  attr_reader :interface, :game_board


end
