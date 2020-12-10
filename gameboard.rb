require_relative "./black_marker"
require_relative "./red_marker"
require_relative "./king_marker"

class Gameboard
    attr_reader :current_board, :red_markers, :black_markers, :current_turn, :game_live

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
        @black_markers = 12
        @current_turn = "red"
        @game_live = true

        # Populate cell array
        self.populate_cell_array

        # Populate new board
        self.populate_new_board

        # # Update possible starting moves
        # self.update_possible_marker_moves
    end

    def populate_new_board
        # Populate black markers
        @current_board[:a1] = BlackMarker.new
        @current_board[:c1] = BlackMarker.new
        @current_board[:e1] = BlackMarker.new
        @current_board[:g1] = BlackMarker.new
        @current_board[:b2] = BlackMarker.new
        @current_board[:d2] = BlackMarker.new
        @current_board[:f2] = BlackMarker.new
        @current_board[:h2] = BlackMarker.new
        @current_board[:a3] = BlackMarker.new
        @current_board[:c3] = BlackMarker.new
        @current_board[:e3] = BlackMarker.new
        @current_board[:g3] = BlackMarker.new

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
end