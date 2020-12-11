require_relative('./marker.rb')

class RedMarker < Marker
    def initialize
        super("red")
    end

    def update_valid_moves(board, current_state, current_position)

        # Reset moves
        @valid_moves = []
        @jump_moves = {}

        # Check current row and index position in row
        current_row = current_position[1].to_i - 1
        cell_index = board[current_row].find_index current_position

        # Store next row
        next_row = board[current_row - 1]

        # Store diagonal move positions
        diagonal_right_cell_index = cell_index + 1
        diagonal_left_cell_index = cell_index - 1

        # Get diagonal right cell
        if diagonal_right_cell_index <= 7 then diagonal_right_cell = next_row[diagonal_right_cell_index] end
        # Check if empty - yes then valid move 
        if diagonal_right_cell && !current_state[diagonal_right_cell]
            @valid_moves << diagonal_right_cell
        # If contains opposite marker - check if can be jumped
        elsif diagonal_right_cell && current_state[diagonal_right_cell].color == "black"
            jump_index = diagonal_right_cell_index + 1
            jump_row = board[current_row - 2]   # Improve logic flow here
            unless jump_index > 7 then jump_cell = jump_row[jump_index] end
            if jump_cell && !current_state[jump_cell]
                @valid_moves << jump_cell
                @jump_moves[jump_cell] = [diagonal_right_cell]
            end
        end

        # Get diagonal left cell
        if diagonal_left_cell_index >= 0 then diagonal_left_cell = next_row[diagonal_left_cell_index] end
        # Check if empty - yes then valid move
        if diagonal_left_cell && !current_state[diagonal_left_cell]
            @valid_moves << diagonal_left_cell
        # If contains opposite marker - check if can be jumped
        elsif diagonal_left_cell && current_state[diagonal_left_cell].color == "black"
            jump_index = diagonal_left_cell_index - 1
            jump_row = board[current_row - 2]   # Improve logic flow here
            unless jump_index < 0 then jump_cell = jump_row[jump_index] end
            if jump_cell && !current_state[jump_cell]
                @valid_moves << jump_cell
                @jump_moves[jump_cell] = [diagonal_left_cell]
            end
        end

end