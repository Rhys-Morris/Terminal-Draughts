require_relative "../gameboard"
require_relative "../marker"
require_relative "../red_marker"
require_relative "../blue_marker"
require_relative "../king_marker"

# Tests for Marker class
describe 'Marker' do

    it "should have a color property of red when red passed as instantiation argument" do
        red_marker = Marker.new("red")
        expect(red_marker.color).to eq("red")
    end

    it "should have a color property of blue when blue passed as instantiation argument" do
        blue_marker = Marker.new("blue")
        expect(blue_marker.color).to eq("blue")
    end

    it "should be instantiated with an empty valid_moves array" do
        new_marker = Marker.new("red")
        expect(new_marker.valid_moves).to eq([])
        expect(new_marker.valid_moves).to be_an_instance_of Array
    end

    it "should be instantiated with an empty jump_moves object" do
        new_marker = Marker.new("red")
        expect(new_marker.jump_moves).to eq({})
        expect(new_marker.jump_moves).to be_an_instance_of Hash
    end

    it "should have a readable property king that is instantiated to false" do
        new_marker = Marker.new("red")
        expect(new_marker.king).to be false
    end

end

# Tests for RedMarker class
describe 'RedMarker' do
    
    it "should have a color property of red" do
        red_marker = RedMarker.new
        expect(red_marker.color).to eq("red")
    end
end

# Tests for BlueMarker class
describe 'BlueMarker' do

    it "should have a color property of blue" do
        blue_marker = BlueMarker.new
        expect(blue_marker.color).to eq("blue")
    end
end

#Tests for KingMarker classes
describe 'KingMarker' do
    it "should return an instance of KingMarker when called" do
        red_king = KingMarker.new('red')
        expect(red_king.king).to be true
        expect(red_king.color).to eq "red"
        expect(red_king).to be_an_instance_of KingMarker
    end
end

#Tests for Gameboard class
describe 'Gameboard' do

    before(:each) do
        @new_game = Gameboard.new
    end


    it "should be initialised with correct marker counts" do
        expect(@new_game.blue_markers).to be 12
        expect(@new_game.red_markers).to be 12
    end

    it "should be initialised with correctly positioned markers" do
        expect(@new_game.current_board[:a1].color).to eq "blue"
        expect(@new_game.current_board[:h8].color).to eq "red"
        expect(@new_game.current_board[:f4]).to be nil
    end

    it "should be initialised with a current_board hash" do
        expect(@new_game.current_board).to be_an_instance_of Hash
    end

    it "should be initialised with a current turn of red" do
        expect(@new_game.current_turn).to eq "red"
    end

    # Decrement marker count method
    describe "decrement_marker_count" do
        it "should decrement marker count by 1 when called" do
            @new_game.decrement_marker_count('blue')
            @new_game.decrement_marker_count('red')
            expect(@new_game.blue_markers).to be 11
            expect(@new_game.red_markers).to be 11
        end
    end

    # Check win method
    describe "check_win" do
        it "should be false when first initiated" do
            expect(@new_game.check_win).to be false
        end

        it "should be true when marker count is 0" do
            12.times do
                @new_game.decrement_marker_count("red")
            end
            expect(@new_game.red_markers).to be 0
            expect(@new_game.check_win).to be true
        end
    end

    # Print winner
    describe "print_winner" do
        it "should print blue when red_markers is 0" do
            12.times do
                @new_game.decrement_marker_count("red")
            end
            expect(@new_game.red_markers).to be 0
            expect(@new_game.print_winner).to eq "\nBlue is the winner!"
        end

        it "should print red when blue_markers is 0" do
            12.times do
                @new_game.decrement_marker_count("blue")
            end
            expect(@new_game.blue_markers).to be 0
            expect(@new_game.print_winner).to eq "\nRed is the winner!"
        end
    end

    # Update Turn
    describe "update_turn" do
        it "current turn should be blue after first update" do
            @new_game.update_turn
            expect(@new_game.current_turn).to eq "blue"
        end

        it "current turn should be red after called twice" do
            @new_game.update_turn
            @new_game.update_turn
            expect(@new_game.current_turn).to eq "red"
        end
    end
end