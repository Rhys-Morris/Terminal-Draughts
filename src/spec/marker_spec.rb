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
