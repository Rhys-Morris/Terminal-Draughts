require_relative "./blue_marker"
require_relative "./red_marker"
require_relative "./king_marker"
require "colorize"

class Gameboard
    attr_reader :current_board, :red_markers, :blue_markers, :current_turn, :game_live, :winner

    ## Marker positions and rows
    @@row1 = [:a1, :b1, :c1, :d1, :e1, :f1, :g1, :h1]
    @@row2 = [:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2]
    @@row3 = [:a3, :b3, :c3, :d3, :e3, :f3, :g3, :h3]
    @@row4 = [:a4, :b4, :c4, :d4, :e4, :f4, :g4, :h4]
    @@row5 = [:a5, :b5, :c5, :d5, :e5, :f5, :g5, :h5]
    @@row6 = [:a6, :b6, :c6, :d6, :e6, :f6, :g6, :h6]
    @@row7 = [:a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7]
    @@row8 = [:a8, :b8, :c8, :d8, :e8, :f8, :g8, :h8]
    @@rows = [@@row1, @@row2, @@row3, @@row4, @@row5, @@row6, @@row7, @@row8]
    @@cells = []

    def populate_cell_array
        @@rows.each do |row|
            row.each do |cell|
                @@cells << cell
            end
        end
    end

    def initialize
        @current_board = {}
        @red_markers = 12
        @blue_markers = 12
        @current_turn = "red"
        @game_live = true
        @winner = nil

        # Populate cell array
        self.populate_cell_array

        # Populate new board
        self.populate_new_board

        # Update possible starting moves
        self.update_possible_marker_moves
    end

    def populate_new_board
        # Populate black markers
        @current_board[:a1] = BlueMarker.new
        @current_board[:c1] = BlueMarker.new
        @current_board[:e1] = BlueMarker.new
        @current_board[:g1] = BlueMarker.new
        @current_board[:b2] = BlueMarker.new
        @current_board[:d2] = BlueMarker.new
        @current_board[:f2] = BlueMarker.new
        @current_board[:h2] = BlueMarker.new
        @current_board[:a3] = BlueMarker.new
        @current_board[:c3] = BlueMarker.new
        @current_board[:e3] = BlueMarker.new
        @current_board[:g3] = BlueMarker.new

        # Populate red markers
        @current_board[:b6] = RedMarker.new
        @current_board[:d6] = RedMarker.new
        @current_board[:f6] = RedMarker.new
        @current_board[:h6] = RedMarker.new
        @current_board[:a7] = RedMarker.new
        @current_board[:c7] = RedMarker.new
        @current_board[:e7] = RedMarker.new
        @current_board[:g7] = RedMarker.new
        @current_board[:b8] = RedMarker.new
        @current_board[:d8] = RedMarker.new
        @current_board[:f8] = RedMarker.new
        @current_board[:h8] = RedMarker.new

        # Populate empty spots
        @current_board[:b4] = nil
        @current_board[:d4] = nil
        @current_board[:f4] = nil
        @current_board[:h4] = nil
        @current_board[:a5] = nil
        @current_board[:c5] = nil
        @current_board[:e5] = nil
        @current_board[:g5] = nil
    end

    def print_board
        puts ""
        puts "   A  B  C  D  E  F  G  H  "
        puts ""
        @@rows.each do |row|
            # Print row number
            print row[0][1] + " "

            # Print each cell
            row.each do |cell|
                cell = cell.to_sym
                board_position = @current_board[cell]
                if board_position == nil
                    print "   "
                else
                    if !@current_board[cell].king
                        print @current_board[cell].color == "red" ?
                        " O ".colorize(:red) :
                        " O ".colorize(:blue)
                    else
                        print @current_board[cell].color == "red" ?
                        " K ".colorize(:red) :
                        " K ".colorize(:blue)
                    end
                end
            end

            # Space rows
            puts ""
            puts ""
        end
    end

    # Return boolean
    def check_win
        @blue_markers == 0 || @red_markers == 0
    end
    
    # Print game winner
    def print_winner
        if @blue_markers == 0
            "\nRed is the winner!"
            @winner = "red"
        elsif @red_markers == 0
            "\nBlue is the winner!"
            @winner = "blue"
        end
    end
    
    def handle_game_over
        @game_live = false
        self.update_win_history
    end

    def update_win_history
        f = File.open("./game_history/win_counts.txt", "r")
        blue_wins = ""
        red_wins = ""
        f.readlines.each_with_index do |line, index|
            if index == 2
                blue_wins = line
            elsif index == 3
                red_wins = line
            end
        end
        f.close
        blue_win_count = blue_wins.split(' ')[1].to_i
        red_win_count = red_wins.split(' ')[1].to_i
        f = File.open("./game_history/win_counts.txt", "w")
        f.write("Win Counts")
        f.write("\n\n")
        if @winner == "blue"
            f.write("Blue: #{blue_win_count + 1}")
        else
            f.write(blue_wins)
        end
        if @winner == "red"
            f.write("Red: #{red_win_count + 1}")
        else
            f.write(red_wins)
        end
        f.close
    end
    
    # Print current turn
    def print_turn
        puts "\nIt is #{@current_turn.capitalize}'s turn!"
    end
    
    def print_marker_counts
        puts "\nThe current marker counts are:\nBlue: #{@blue_markers}\nRed: #{@red_markers}"
    end
    
    # Update color turn
    def update_turn
        @current_turn = @current_turn == "red" ? "blue" : "red"
    end
    
    # Decrement marker count
    def decrement_marker_count(color)
        if color == "red"
            @red_markers -= 1
        else
            @blue_markers -= 1
        end
    end

    # Iterate over all cells to find where markers are positioned
    # Call update_valid_moves to populate possible moves on each marker
    def update_possible_marker_moves
        @@cells.each do |cell|
            if @current_board[cell]
                @current_board[cell].update_valid_moves(@@rows, @current_board, cell)
            end
        end
    end

    # Returns a marker of current turn's colour 
    def select_marker
        puts "\nSelect a marker to move:"
        selection = gets.chomp.downcase.to_sym
        if !@@cells.include? selection
            puts "\nInvalid selection. Please select again!"
            self.select_marker
        else
            if @current_board[selection] == nil || @current_board[selection].color != @current_turn
                puts "\nInvalid selection. You must select a marker of your color. Please select again!"
                self.select_marker
            else
                return @current_board[selection]
            end
        end
    end

    # Return a position on the gameboard
    def select_move_position
        puts "\nSelect a position to move to:"
        selection = gets.chomp.downcase.to_sym
        if !@@cells.include? selection
            puts "\nInvalid selection. Please select again!"
            self.select_move_position
        else
            return selection
        end
    end

    # Return boolean
    def check_valid_move(marker, move_position)
        return marker.valid_moves.include? move_position
    end

    # Make a move
    def make_move

        #Clear screen
        system "clear"

        # Print current turn
        self.print_board
        self.print_marker_counts
        self.print_turn

        # Loop move selection until valid
        while true
            marker_to_move = self.select_marker
            position_to_move = self.select_move_position

            # Valid move? - Update board and turn
            if check_valid_move(marker_to_move, position_to_move)
                self.update_board(marker_to_move, position_to_move)             
                self.update_turn

                # Check if game has been won
                if self.check_win
                    self.print_winner
                    self.handle_game_over
                end
                return

            # Handle invalid move selection
            else
                puts "\nInvalid move selection! Please try again!"
                self.print_board
            end
        end
    end

    def update_board(moved_marker, position_moved_to)
        
        # Is this a jump move?
        if moved_marker.jump_moves.include? position_moved_to

            #Handle deletion of jumped markers
            moved_marker.jump_moves[position_moved_to].each do |opposite_marker|
                # puts "Attempting to delete #{@current_board[opposite_marker]}"            # DEBUGGING
                @current_board[opposite_marker] = nil

                # Decrement marker count
                if @current_turn == "red" then self.decrement_marker_count("blue") end
                if @current_turn == "blue" then self.decrement_marker_count("red") end
            end
        end

        # Delete marker from previous position
        @@cells.each do |cell|
            if @current_board[cell] == moved_marker then @current_board[cell] = nil end
        end

        # Add marker to new position
        if @current_turn == "red"
            if moved_marker.king
                @current_board[position_moved_to] = KingMarker.new("red")
            else
                @current_board[position_moved_to] = RedMarker.new
            end
        else
            if moved_marker.king
                @current_board[position_moved_to] = KingMarker.new("blue")
            else
                @current_board[position_moved_to] = BlueMarker.new
            end
        end

        # Check if any markers need to be converted to Kings
        red_king_row = @@rows[0]
        blue_king_row = @@rows[7]

        red_king_row.each do |cell|
            if !current_board[cell]
                next
            elsif @current_board[cell].color == "red"
                @current_board[cell] = KingMarker.new("red")
            end
        end

        blue_king_row.each do |cell|
            if !current_board[cell]
                next
            elsif @current_board[cell].color == "blue"
                @current_board[cell] = KingMarker.new("blue")
            end
        end

        # Update possible moves
        self.update_possible_marker_moves
    end
end