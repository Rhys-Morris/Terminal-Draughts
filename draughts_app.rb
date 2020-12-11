require "tty-progressbar"
require "tty-prompt"
require_relative './errors.rb'
require_relative './gameboard.rb'

# ----- HANDLE COMMAND LINE ARGUMENTS -----

# ----- HELPER FUNCTIONS -----

# Welcome message
def welcome 

    system "clear"
    puts "
    ██████╗░██████╗░░█████╗░██╗░░░██╗░██████╗░██╗░░██╗████████╗░██████╗
    ██╔══██╗██╔══██╗██╔══██╗██║░░░██║██╔════╝░██║░░██║╚══██╔══╝██╔════╝
    ██║░░██║██████╔╝███████║██║░░░██║██║░░██╗░███████║░░░██║░░░╚█████╗░
    ██║░░██║██╔══██╗██╔══██║██║░░░██║██║░░╚██╗██╔══██║░░░██║░░░░╚═══██╗
    ██████╔╝██║░░██║██║░░██║╚██████╔╝╚██████╔╝██║░░██║░░░██║░░░██████╔╝
    ╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░\n\n\n"

    # Progress bar
    bar = TTY::ProgressBar.new("[:bar]", total: 80)
    100.times do
        sleep(0.01)
        bar.advance(1)
    end

    main_menu
end

# Make a selection at main menu
def main_menu
    prompt = TTY::Prompt.new(
        active_color: :red,
        symbols: {marker: "⮊"},
        quiet: true
    )

    puts ""
    menu_selection = prompt.select("Select an option:") do |menu|
        menu.choice "➊ Start a new game", 1
        menu.choice "➋ How to play", 2
        menu.choice "➌ Display game history", 3
        menu.choice "➍ Exit program", 4
    end

    case menu_selection
    when 1
        start_game
    when 2
        instructions
    when 3
        check_win_history
    when 4
        puts "\nGoodbye!"
        sleep(2)
        exit
    else
        raise InvalidMenu
    end

    rescue InvalidMenu
        puts "Invalid menu input. Please try again!"
        retry
    # rescue
    #     puts "An unexpected error occurred, the program will now exit"
    #     exit
end

# Create a new game and allow gameboard logic to control flow
def start_game
    new_game = Gameboard.new
    while new_game.game_live
        new_game.make_move
    end

    # Prompt to return to main menu
    puts "\nEnter y when ready to return to menu"
    selection = ""
    while selection != "y"
        selection = gets.chomp.downcase
    end
    welcome
end

# How to play instructions
def instructions
    system "clear"
    puts "How to Play"
    puts "\n\n"
    puts "Select a marker by typing into terminal"
    puts "\nEnter y when ready to return to menu"
    selection = ""
    while selection != "y"
        selection = gets.chomp.downcase
    end
    welcome
end

# Check win history
def check_win_history
    # Open file that is storing previous game data
    # Print data to screen
    # Close file
    # Return to menu
end

# Initialise program flow
welcome

