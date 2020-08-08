class Interface
  attr_accessor :player

  def menu(state)
    if state.zero?
      greetings
      self.player = get_new_player
    else
      back
    end

    options
  end

  # This is horrendous xD

  def display_board(game_board, guesser)
    puts %(Color matches: 1 - #{output_color(' Black ', 1)}; 2 - #{output_color(' Cyan ', 2)}; 3 - #{output_color(' Red ', 3)}; 4 - #{output_color(' Yellow ', 4)}; 5 - #{output_color(' Magenta ', 5)}; 6 - #{output_color(' Blue ', 6)}
     Guessing: #{guesser.name}

      ___________________________
     |   |   |   |   |   |   |   |
     | x | #{game_board.get_game(0, 0)} | #{game_board.get_game(1, 0)} | #{game_board.get_game(2, 0)} | #{game_board.get_game(3, 0)} | #{game_board.get_game(4, 0)} | #{game_board.get_game(5, 0)} |
     | x | #{game_board.get_game(0, 1)} | #{game_board.get_game(1, 1)} | #{game_board.get_game(2, 1)} | #{game_board.get_game(3, 1)} | #{game_board.get_game(4, 1)} | #{game_board.get_game(5, 1)} |
     | x | #{game_board.get_game(0, 2)} | #{game_board.get_game(1, 2)} | #{game_board.get_game(2, 2)} | #{game_board.get_game(3, 2)} | #{game_board.get_game(4, 2)} | #{game_board.get_game(5, 2)} |
     | x | #{game_board.get_game(0, 3)} | #{game_board.get_game(1, 3)} | #{game_board.get_game(2, 3)} | #{game_board.get_game(3, 3)} | #{game_board.get_game(4, 3)} | #{game_board.get_game(5, 3)} |
     |___|___|___|___|___|___|___|
     )
  end

  # Used in order to clear the screen and keep the interface readable.
  def clear_screen
    system('clear') || system('cls')
  end

  def output_color(text, color)
    # Color matches: 1 - Black; 2 - White; 3 - Red; 4 - Yellow; 5 - Green; 6 - Blue
    colors = { 1 => 30, 2 => 36, 3 => 31, 4 => 33, 5 => 35, 6 => 34 }
    # \e[47m Is for the grey foreground \e[{color} is for picking the color and \e[0m is for resetting the terminal.
    "\e[1m\e[47m\e[#{colors[color]}m#{text}\e[0m\e[22m"
  end

  def invalid_input(input)
    clear_screen
    puts "That was not a valid input: #{input}\n"
    sleep(1.5)
  end

  private

  attr_accessor :board

  def get_new_player
    puts 'First of all, what is your name?'
    name = gets.chomp!
    Player.new(name, self, board)
  end

  def greetings
    puts "Hello and welcome to MiDDiz's implementation of the popular game, Mastermind!\n"
  end

  def back
    puts 'Welcome back, the menu options are: '
  end

  # @return nothing because we go to other methods.
  def start_game
    clear_screen
    puts 'Do you want to type the code (t) or guess it (g)?'
    # TODO: Integrate typing the code.
    puts 'Typing the code yourself is still not implemented, sorry!'
    input = gets.chomp.to_sym
    case input
    when :g
      self.board =  GameBoard.new('guessing', player, self)
    #    when :t
    #      GameBoard.new('typing', player_name)
    else
      invalid_input(input)
      start_game
    end
  end

  def credits
    # TODO: Implement this
  end

  def options
    loop do
      puts 'To start the game return:   s'
      puts 'To read the credits return: c'
      puts 'To quit just return:        q'
      input = gets.chomp.to_sym
      case input
      when :s
        start_game
        break
      when :c
        credits
        break
      when :q
        quit
        break
      else
        invalid_input(input)
      end
    end
  end

  def ask_for_input
    puts "Type four numbers, between 1 to 6, and guess the code!\n"
    gets.chomp
  end
end
