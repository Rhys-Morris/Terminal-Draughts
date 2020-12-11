require_relative('./marker.rb')

class BlueMarker < Marker
    def initialize
        super("blue")
    end

    def update_valid_moves(board, current_state, current_position)

        # Reset moves
        @valid_moves = []
        @jump_moves = {}

        # Check current row and index position in row
        current_row = current_position[1].to_i - 1
        cell_index = board[current_row].find_index current_position

        # Store next row
        next_row = board[current_row + 1]

        # Store diagonal move positions
        diagonal_right_cell_index = cell_index - 1
        diagonal_left_cell_index = cell_index + 1

        # Get diagonal right cell
        if diagonal_right_cell_index >= 0 then diagonal_right_cell = next_row[diagonal_right_cell_index] end

        # If empty push to valid moves
        if diagonal_right_cell && !current_state[diagonal_right_cell]
            @valid_moves << diagonal_right_cell

        # If contains opposite marker - check if can be jumped
        elsif diagonal_right_cell && current_state[diagonal_right_cell].color == "red"
            jump_cell_index = diagonal_right_cell_index - 1
            jump_row_index = current_row + 2
            unless jump_cell_index < 0 || jump_row_index > 7
                jump_row = board[jump_row_index]
                jump_cell = jump_row[jump_cell_index]
            end
            if jump_cell && !current_state[jump_cell]
                @valid_moves << jump_cell
                @jump_moves[jump_cell] = [diagonal_right_cell]
                self.check_additional_jump(board, current_state, jump_cell, [diagonal_right_cell])
            end
        end

        # Get diagonal left cell
        if diagonal_left_cell_index <= 7 then diagonal_left_cell = next_row[diagonal_left_cell_index] end

        # Check if empty - yes then valid move
        if diagonal_left_cell && !current_state[diagonal_left_cell]
            @valid_moves << diagonal_left_cell

            # If contains opposite marker - check if can be jumped
        elsif diagonal_left_cell && current_state[diagonal_left_cell].color == "red"
            jump_cell_index = diagonal_left_cell_index + 1
            jump_row_index = current_row + 2 
            unless jump_cell_index > 7 || jump_row_index > 7
                jump_row = board[jump_row_index]
                jump_cell = jump_row[jump_cell_index]
            end
            if jump_cell && !current_state[jump_cell]
                @valid_moves << jump_cell
                @jump_moves[jump_cell] = [diagonal_left_cell]
                self.check_additional_jump(board, current_state, jump_cell, [diagonal_left_cell])
            end
        end
    end

    def check_additional_jump(board, current_state, current_position, jumps)
        
        # Get current row and cell index
        current_row_index = current_position[1].to_i - 1
        cell_index = board[current_row_index].find_index current_position
        
        # Get diagonal cell and next row indexes
        diagonal_left_index = cell_index + 1
        diagonal_right_index = cell_index - 1
        next_row_index = current_row_index + 1

        # Get next row and diagonal cells
        if next_row_index <= 6 then next_row = board[next_row_index] end
        if next_row && diagonal_left_index <= 6 then diagonal_left_cell = next_row[diagonal_left_index] end
        if next_row && diagonal_right_index >= 1 then diagonal_right_cell = next_row[diagonal_right_index] end
        
        # Check if diagonal cells contain an opposite color marker
        if diagonal_right_cell && current_state[diagonal_right_cell]
            if current_state[diagonal_right_cell].color == "red"
                jump_row_index = next_row_index + 1
                jump_cell_index = diagonal_right_index - 1
                if jump_row_index <= 7 then jump_row = board[jump_row_index] end
                if jump_cell_index >= 0 then jump_cell = jump_row[jump_cell_index] end
                if jump_cell && !current_state[jump_cell]
                    @valid_moves << jump_cell
                    jumps_copy = jumps.dup
                    jumps_copy << diagonal_right_cell
                    @jump_moves[jump_cell] = jumps_copy
                    self.check_additional_jump(board, current_state, jump_cell, jumps_copy)
                end
            end
        end

        if diagonal_left_cell && current_state[diagonal_left_cell]
            if current_state[diagonal_left_cell].color == "red"
                jump_row_index = next_row_index + 1
                jump_cell_index = diagonal_left_index + 1
                if jump_row_index <= 7 then jump_row = board[jump_row_index] end
                if jump_cell_index <= 7 then jump_cell = jump_row[jump_cell_index] end
                if jump_cell && !current_state[jump_cell]
                    @valid_moves << jump_cell
                    jump_copy = jumps.dup
                    jumps_copy << diagonal_left_cell
                    @jump_moves[jump_cell] = jumps_copy
                    self.check_additional_jump(board, current_state, jump_cell, jumps_copy)
                end
            end
        end

    end

end