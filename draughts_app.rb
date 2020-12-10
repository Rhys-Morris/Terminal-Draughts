# Handle command line arguments
require "tty-progressbar"



# Helper functions

# Welcome message
def welcome 

    puts "Welcome to the game!"

    # Progress bar
    bar = TTY::ProgressBar.new("Loading! [:bar]", total: 100)
    100.times do
        sleep(0.05)
        bar.advance(1)
    end

    menu_selection
end

# Make a selection at main menu
def menu_selection
    puts "Menu!"
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
