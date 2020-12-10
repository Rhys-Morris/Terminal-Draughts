class Marker
    attr_reader :color, :valid_moves, :jump_moves, :king
    
    def initialize(color)
        @color = color
        @valid_moves = []
        @jump_moves = {}
        @king = false
    end
    
end