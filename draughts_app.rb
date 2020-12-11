require "tty-progressbar"
require "tty-prompt"
require "colorize"
require_relative './errors.rb'
require_relative './gameboard.rb'

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
        menu.choice "➌ Display win counts", 3
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
    win_history = File.open("./game_history/win_counts.txt")
    win_history.readlines.each_with_index do |line, index|
        if index == 2
            split_line = line.strip.split(' ')
            puts "#{split_line[0].colorize(:blue)}: #{split_line[1].to_i}"
        elsif index == 3
            split_line = line.strip.split(' ')
            puts "#{split_line[0].colorize(:red)}: #{split_line[1].to_i}"
        else 
            puts line
        end
    end
    win_history.close

    puts "\nEnter y when ready to return to menu"
    selection = ""
    while selection != "y"
        selection = gets.chomp.downcase
    end
    welcome
end

# ----- INITIALISE -----

# ----- HANDLE COMMAND LINE ARGUMENTS -----

def command_line_info
    puts "\nCommand line arguments:\n\n"
    puts "-h or --help      Display all command line arguments"
    puts "-i or --info      Display instructions on how to play"
    puts "start             Skip menu and immediately start a new game"
    puts "wins              Print win counts"
    puts ""
end

def handle_flags
    case ARGV[0]
    when "-h"
        command_line_info
        exit
    when "--help"
        command_line_info
        exit
    when "-i"
        ARGV.clear
        instructions
    when "--info"
        ARGV.clear
        instructions
    when "start"
        ARGV.clear
        start_game
    when "wins"
        ARGV.clear
        check_win_history
    end
end

if ARGV.length != 0
    handle_flags
end

# Default program start
welcome

