require "tty-progressbar"
require "tty-prompt"
require_relative './errors.rb'

# Handle command line arguments

# ----- HELPER FUNCTIONS -----

# Welcome message
def welcome 

    puts "Welcome to the game!"

    # Progress bar
    bar = TTY::ProgressBar.new("Loading! [:bar]", total: 100)
    100.times do
        sleep(0.01)
        bar.advance(1)
    end

    menu_selection
end

# Make a selection at main menu
def menu_selection
    prompt = TTY::Prompt.new

    menu_selection = prompt.select("Select an option:") do |menu|
        menu.choice "1. Start a new game", 1
        menu.choice "2. How to play", 2
        menu.choice "3. Display game history", 3
        menu.choice "4. Exit program", 4
    end

    case menu_selection
    when 1
        puts "Pressed 1"
    when 2
        puts "Pressed 2"
    when 3
        puts "Pressed 3"
    when 4
        puts "Pressed 4"
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

# Program logic

system "clear"
welcome

puts "Made it to end"

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
