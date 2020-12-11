require_relative './marker'

class KingMarker < Marker
    def initialize(color)
        super(color)
        self.flag_king
    end

    def flag_king
        @king = true
    end

    def update_valid_moves(board, current_state, current_position)
        
        opposite_color = @color == "red" ? "blue" : "red"

        # Reset moves
        @valid_moves = []
        @jump_moves = {}

        # Check current row and index position in row
        current_row = current_position[1].to_i - 1
        cell_index = board[current_row].find_index current_position

        # Get row above and below
        row_above_index = current_row - 1
        row_below_index = current_row + 1

        row_above = row_above_index < 0 ? nil : board[row_above_index]
        row_below = row_below_index > 7 ? nil : board[row_below_index]

        # Get diagonal move positions
        left_index = cell_index - 1
        right_index = cell_index + 1

        if row_above && left_index >= 0
            above_left = row_above[left_index]
        end

        if row_above && right_index <= 7
            above_right = row_above[right_index]
        end

        if row_below && left_index >= 0
            below_left = row_below[left_index]
        end

        if row_below && right_index <= 7
            below_right = row_below[right_index]
        end

        # Check if cell is empty and a valid move
        if above_left && current_state[above_left] == nil
            @valid_moves << above_left
        end

        if above_right && current_state[above_right] == nil
            @valid_moves << above_right
        end

        if below_left && current_state[below_left] == nil
            @valid_moves << below_left
        end

        if below_right && current_state[below_right] == nil
            @valid_moves << below_right
        end

        # Create new current_state to modify to prevent modification of original board
        current_state_new = current_state.dup
        # Remove marker from this position to facilitate possible return
        current_state_new[current_position] = nil

        # Check for jumps in surrounding cells
        if above_left && current_state[above_left]
            if current_state[above_left].color == opposite_color
                jump_row_index = row_above_index - 1
                jump_row = jump_row_index >= 0 ? board[jump_row_index] : nil
                jump_cell_index = left_index - 1
                unless !jump_row
                    jump_cell = jump_cell_index >= 0 ? jump_row[jump_cell_index] : nil
                end
                unless !jump_cell
                    if !current_state[jump_cell]
                        @valid_moves << jump_cell
                        @jump_moves[jump_cell] = [above_left]
                        # Remove jumped cell from current state board
                        current_state_new[above_left] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, [above_left], current_position)
                    end
                end
            end
        end

        if above_right && current_state[above_right]
            if current_state[above_right].color == opposite_color
                jump_row_index = row_above_index - 1
                jump_row = jump_row_index >= 0 ? board[jump_row_index] : nil
                jump_cell_index = right_index + 1
                unless !jump_row
                    jump_cell = jump_cell_index <= 7 ? jump_row[jump_cell_index] : nil
                end
                unless !jump_cell
                    if !current_state[jump_cell]
                        @valid_moves << jump_cell
                        @jump_moves[jump_cell] = [above_right]
                        # Remove jumped cell from current state board
                        current_state_new[above_left] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, [above_right], current_position)
                    end
                end
            end
        end

        if below_left && current_state[below_left]
            if current_state[below_left].color == opposite_color
                jump_row_index = row_below_index + 1
                jump_row = jump_row_index <= 7 ? board[jump_row_index] : nil
                jump_cell_index = left_index - 1
                unless !jump_row
                    jump_cell = jump_cell_index >= 0 ? jump_row[jump_cell_index] : nil
                end
                unless !jump_cell
                    if !current_state[jump_cell]
                        @valid_moves << jump_cell
                        @jump_moves[jump_cell] = [below_left]
                        # Remove jumped cell from current state board
                        current_state_new[above_left] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, [below_left], current_position)
                    end
                end
            end
        end

        if below_right && current_state[below_right]
            if current_state[below_right].color == opposite_color
                jump_row_index = row_below_index + 1
                jump_row = jump_row_index <= 7 ? board[jump_row_index] : nil
                jump_cell_index = right_index + 1
                unless !jump_row
                    jump_cell = jump_cell_index <= 7 ? jump_row[jump_cell_index] : nil
                end
                unless !jump_cell
                    if !current_state[jump_cell]
                        @valid_moves << jump_cell
                        @jump_moves[jump_cell] = [below_right]
                        # Remove jumped cell from current state board
                        current_state_new[above_left] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, [below_right], current_position)
                    end
                end
            end
        end

        # Debugging
        pp @valid_moves
        puts @jump_moves
        # pp current_state
    end

    def check_additional_jump(board, current_state, current_position, jumps, previous_position)
        
        opposite_color = @color == "red" ? "blue" : "red"                           

        # Get current row and cell index
        current_row_index = current_position[1].to_i - 1
        cell_index = board[current_row_index].find_index current_position
        
        # Get diagonal cell and above and below row indexes
        left_index = cell_index - 1
        right_index = cell_index + 1
        below_row_index = current_row_index + 1
        above_row_index = current_row_index - 1

        # Get below row and diagonal cells
        if below_row_index <= 6 then below_row = board[below_row_index] end
        if below_row && left_index >= 1 then below_left_cell = below_row[left_index] end
        if below_row && right_index <= 6 then below_right_cell = below_row[right_index] end

        # Get above row and diagonal cells
        if above_row_index <= 6 then above_row = board[above_row_index] end
        if above_row && left_index >= 1 then above_left_cell = above_row[left_index] end
        if above_row && right_index <= 6 then above_right_cell = above_row[right_index] end

        # Create new current_state to modify to prevent modification of original board
        current_state_new = current_state.dup
        
        # Check if below cells contain an opposite color marker that can be jumped
        if below_right_cell && current_state[below_right_cell]
            if current_state[below_right_cell].color == opposite_color
                jump_row_index = below_row_index + 1
                jump_cell_index = right_index + 1
                if jump_row_index <= 7 then jump_row = board[jump_row_index] end
                if jump_cell_index <= 7 then jump_cell = jump_row[jump_cell_index] end
                # Prevent moving backwards and infinite loop
                unless jump_cell == previous_position
                    if jump_cell && !current_state[jump_cell]
                        @valid_moves << jump_cell
                        jumps_copy = jumps.dup
                        puts current_position
                        jumps_copy << below_right_cell
                        @jump_moves[jump_cell] = jumps_copy
                        # Remove jumped cell from current state board
                        current_state_new[below_right_cell] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, jumps_copy, current_position)
                    end
                end
            end
        end

        if below_left_cell && current_state[below_left_cell]
            if current_state[below_left_cell].color == opposite_color
                jump_row_index = below_row_index + 1
                jump_cell_index = left_index - 1
                if jump_row_index <= 7 then jump_row = board[jump_row_index] end
                if jump_cell_index >= 0 then jump_cell = jump_row[jump_cell_index] end
                # Prevent moving backwards and infinite loop
                unless jump_cell == previous_position
                    if jump_cell && !current_state[jump_cell]
                        @valid_moves << jump_cell
                        jumps_copy = jumps.dup
                        jumps_copy << below_left_cell
                        @jump_moves[jump_cell] = jumps_copy
                        # Remove jumped cell from current state board
                        current_state_new[below_left_cell] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, jumps_copy, current_position)
                    end
                end
            end
        end

        # Check if above cells contain an opposite color marker that can be jumped
        if above_right_cell && current_state[above_right_cell]
            if current_state[above_right_cell].color == opposite_color
                jump_row_index = above_row_index - 1
                jump_cell_index = right_index + 1
                if jump_row_index >= 0 then jump_row = board[jump_row_index] end
                if jump_cell_index <= 7 then jump_cell = jump_row[jump_cell_index] end
                # Prevent moving backwards and infinite loop
                unless jump_cell == previous_position
                    if jump_cell && !current_state[jump_cell]
                        @valid_moves << jump_cell
                        jumps_copy = jumps.dup
                        jumps_copy << above_right_cell
                        @jump_moves[jump_cell] = jumps_copy
                        # Remove jumped cell from current state board
                        current_state_new[above_right_cell] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, jumps_copy, current_position)
                    end
                end
            end
        end

        if above_left_cell && current_state[above_left_cell]
            if current_state[above_left_cell].color == opposite_color
                jump_row_index = above_row_index - 1
                jump_cell_index = left_index - 1
                if jump_row_index >= 0 then jump_row = board[jump_row_index] end
                if jump_cell_index >= 0 then jump_cell = jump_row[jump_cell_index] end
                # Prevent moving backwards and infinite loop
                unless jump_cell == previous_position
                    if jump_cell && !current_state[jump_cell]
                        @valid_moves << jump_cell
                        jumps_copy = jumps.dup
                        jumps_copy << above_left_cell
                        @jump_moves[jump_cell] = jumps_copy
                        # Remove jumped cell from current state board
                        current_state_new[above_left_cell] = nil
                        self.check_additional_jump(board, current_state_new, jump_cell, jumps_copy, current_position)
                    end
                end
            end
        end

    end
end