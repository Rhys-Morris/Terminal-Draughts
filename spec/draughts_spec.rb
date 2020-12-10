require_relative "../gameboard.rb"
require_relative "../marker.rb"
require_relative "../red_marker.rb"
require_relative "../black_marker.rb"
require_relative "../king_marker.rb"

# Tests for Marker class
describe 'Marker' do

    it "should have a color property of red when red passed as instantiation argument" do
        red_marker = Marker.new("red")
        expect(red_marker.color).to eq("red")
    end

    it "should have a color property of black when black passed as instantiation argument" do
        black_marker = Marker.new("black")
        expect(black_marker.color).to eq("black")
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

# Tests for BlackMarker class
describe 'BlackMarker' do

    it "should have a color property of black" do
        black_marker = BlackMarker.new
        expect(black_marker.color).to eq("black")
    end
end

#Tests for KingMarker classes
describe 'KingMarker' do
    
end

#Tests for Gameboard class
describe 'Gameboard' do

    before(:each) do
        @new_game = Gameboard.new
    end


    it "should be initialised with correct marker counts" do
        expect(@new_game.black_markers).to be 12
        expect(@new_game.red_markers).to be 12
    end

    it "should be initialised with correctly positioned markers" do
        expect(@new_game.current_board[:a1].color).to eq "black"
        expect(@new_game.current_board[:h8].color).to eq "red"
    end

    it "should be initialised with a current_board hash" do
        expect(@new_game.current_board).to be_an_instance_of Hash
    end

    it "should be initialised with a current turn of red" do
        expect(@new_game.current_turn).to eq "red"
    end
end