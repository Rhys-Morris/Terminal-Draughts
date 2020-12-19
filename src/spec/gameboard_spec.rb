require_relative "../gameboard"

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

    it "should have default player1 and player2 values when instantiated without arguments" do
        expect(@new_game.player_one).to eq "Player 1"
        expect(@new_game.player_two).to eq "Player 2"
    end

    it "should have specific player1 and player2 values when instantiated with arguments" do
        @specific_game = Gameboard.new("Rhys", "Robyn")
        expect(@specific_game.player_one).to eq "Rhys"
        expect(@specific_game.player_two).to eq "Robyn"
    end

    # Decrement marker count method
    describe "decrement_marker_count" do
        it "should decrement marker count by 1 when called" do
            blue_marker_count = @new_game.blue_markers
            red_marker_count = @new_game.red_markers
            @new_game.decrement_marker_count('blue')
            @new_game.decrement_marker_count('red')
            expect(@new_game.blue_markers).to be blue_marker_count - 1
            expect(@new_game.red_markers).to be red_marker_count - 1
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