class GameBoard
  attr_reader :code, :player, :interface, :plays

  def initialize(state, player, interface)
    @code = 0
    @plays = []
    @player = player
    @computer = Computer.new()
    @interface = interface
    if state == 'guessing'
      initialzie_guessing
    else
      initialize_setting
    end
  end

  def get_game(game_index, slot_index)
    begin
      if (self.plays[game_index].to_s[slot_index].equal?(nil))
        raise NoMethodError
      else
        self.plays[game_index].to_s[slot_index]
      end
    rescue NoMethodError
      return " "
    end
  end

  private
  attr_accessor :computer
  attr_writer :code

  # Private getter

  def initialzie_guessing
    self.code = generate_code
    self.player.guessing = true
    play(code)

  end

  def initialize_setting
    # TODO: Implement this xd
  end

  def generate_code
    code = ''
    4.times do
      code += rand(1..6).to_s
    end
    code.to_i
  end



  def play(code)
    interface.display_board(self, player)
    guessed = false
    tries = 0
    until guessed || (tries >= 6)
      tries += 1
      guessing_code = get_input_code
      append_code(guessing_code)
      guessed = compare_play(code, guessing_code)
    end
    end_play(guessed)
  end

  def get_input_code
    if self.player.guessing
      input = self.player.new_code_input
      input = sanitize_input(input)
      unless input
        # Bad input, repeat
        interface.invalid_input
        get_input_code
      end
      input
    else
      self.computer.new_code_input
    end
  end

  def compare_play(code_setter, code_guesser)
    if code_setter.equal?(code_guesser)
      true
    else

    end
  end

  def append_code(code)
    self.plays << code
  end

  def sanitize_input(inputted_code)
    begin
      accepted_numbers = (1..6).to_a
      inputted_code.split("").each do |number|
        unless accepted_numbers.include?(number.to_i)
          raise ArgumentError
        end
      end
    rescue StandardError
      return false
    end
    inputted_code.to_i
  end

  def end_play(has_won)
    if has_won
      win_logic
    else
      lose_logic
    end
  end

  def win_logic
    # If guessing player then prompt interface winning player guessing
    # If player is typing then prompt interface winning player typing
  end

  def lose_logic
    # If guessing player then prompt interface losing player guessing
    # If player is typing then prompt interface losing player typing
  end

end