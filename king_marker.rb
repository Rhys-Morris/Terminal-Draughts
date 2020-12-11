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
    end
end