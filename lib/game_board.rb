# frozen_string_literal: true
class GameBoard
  attr_reader :code, :player, :interface, :plays

  def initialize(state, player, interface)
    @code = 0
    # plays structure: It's an array that stores the codes that the guesser has typed. Also, at the same index,
    # it stores the number of right guesses the guesser has achieved.
    # Numbers of indexes 0 to 3 are the code. Index 4 is the number of position and color guesses. 
    # Index 5 are only color guesses.
    @plays = []
    @player = player
    @computer = Computer.new
    @interface = interface
    if state == 'guessing'
      initialzie_guessing
    else
      initialize_setting
    end
  end

  def get_game(game_index, slot_index)
    
      plays[game_index].to_s[slot_index].equal?(nil) ? raise(StandardError) : plays[game_index].to_s[slot_index]
    rescue StandardError
      ' '
    
  end

  private

  attr_accessor :computer
  attr_writer :code

  # Private getter

  def initialzie_guessing
    self.code = generate_code
    player.guessing = true
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

    guessed = false
    tries = 0
    until guessed || (tries >= 6)
      # TODO: REMVOE THIS
      puts code

      interface.display_board(self, player)
      tries += 1
      guessing_code = get_input_code
      guess_result = compare_play(code, guessing_code)
      guessed = guess_result[0]
      append_code(guess_result[1])
    end
    end_play(guessed)
  end

  def get_input_code
    if player.guessing
      input = player.new_code_input
      input = sanitize_input(input)
      unless input
        # Bad input, repeat
        interface.invalid_input
        get_input_code
      end
      input
    else
      computer.new_code_input
    end
  end

  # This code is shit, I know :p.

  def compare_play(code_to_crack, code_guesser)
    code_passed = code_guesser
    if code_to_crack.equal?(code_guesser)
      [true, (code_guesser.to_s + '4').to_i]
    else
      color_place_guesses = 0
      color_guesses = 0

      # Convert int to array :p

      code_to_crack = code_to_crack.to_s.split('')
      code_guesser = code_guesser.to_s.split('')

      code_to_crack.each_with_index do |e, i|
        next unless e == code_guesser[i]

        code_to_crack[i] = nil
        code_guesser[i] = nil
        color_place_guesses += 1
      end

      code_to_crack.compact!
      code_guesser.compact!

      until code_guesser.length.zero?
        if code_to_crack.include?(code_guesser[0])
          code_to_crack[code_to_crack.index(code_guesser[0])] = nil
          color_guesses += 1
        end
        code_guesser[0] = nil
        code_guesser.compact!
      end

      code_to_crack.compact!
      [false, code_passed.to_s + color_place_guesses.to_s + color_guesses.to_s]
    end
  end

  def append_code(code)
    plays << code
  end

  def sanitize_input(inputted_code)
    begin
      accepted_numbers = (1..6).to_a
      inputted_code.split('').each do |number|
        raise ArgumentError unless accepted_numbers.include?(number.to_i)
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