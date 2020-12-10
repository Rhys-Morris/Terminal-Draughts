require "tty-progressbar"
require "tty-prompt"
require_relative './errors.rb'

# Handle command line arguments

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
    bar = TTY::ProgressBar.new("[:bar]", total: 100)
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
    rescue
        puts "An unexpected error occurred, the program will now exit"
        exit
end

# Create a new game and allow gameboard logic to control flow
def start_game
    new_game = Gameboard.new
    while new_game.game_live
        new_game.make_move
    end

    # Game concluded - return to menu
    welcome
end

# How to play instructions
def instructions
    system "clear"
    puts "
    ╔╗─╔╗─────────╔╗───────╔╗
    ║║─║║────────╔╝╚╗──────║║
    ║╚═╝╠══╦╗╔╗╔╗╚╗╔╬══╗╔══╣║╔══╦╗─╔╗
    ║╔═╗║╔╗║╚╝╚╝║─║║║╔╗║║╔╗║║║╔╗║║─║║
    ║║─║║╚╝╠╗╔╗╔╝─║╚╣╚╝║║╚╝║╚╣╔╗║╚═╝║
    ╚╝─╚╩══╝╚╝╚╝──╚═╩══╝║╔═╩═╩╝╚╩═╗╔╝
    ────────────────────║║──────╔═╝║
    ────────────────────╚╝──────╚══╝"
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
    puts "This section is TO DO"
end

# Program logic

welcome


# Menu selection
# 1. Start a new game
# 2. Print player instructions
# 3. Print game history (from file)
# 4. Exit

# 1.
# Instantiate a new game
# while game is live
# continue making moves
# Once game is won and breaks --> return to menu

# 2.
# Print player instructions
# Return to menu

# 3.
# Open file that is storing previous game data
# Print data to screen
# Close file
# Return to menu

# 4.
# Exit program
