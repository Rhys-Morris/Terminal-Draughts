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
                    end
                end
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