require_relative '../lib/connectfour'
#"\u26AB"
#"\u26AA" 


describe ConnectFour do

    describe '#make_move' do
        subject(:game){ConnectFour.new()} 
        context 'when called' do

            before do
                allow(game).to receive(:gets).and_return("5\n")
                allow(game).to receive(:puts).and_return(nil)
            end

            it 'puts the rows and gets which row to select' do
                expect(game).to receive(:puts).with("|1|2|3|4|5|6|7|")
                expect(game).to receive(:puts).with("row?: ")
                game.make_move
            end
        end

        context 'when @grid is empty and the selected row is 5' do

            before do
                allow(game).to receive(:gets).and_return("5\n")
                game.instance_variable_set(:@current_player,'A')
                game.instance_variable_get(:@grid,Array.new(6){Array.new(7)})
                allow(game).to receive(:puts).and_return(nil)
            end

            it 'sets column 0,index 4 equal to @current_player' do
                expect{game.make_move}.to change{game.instance_variable_get(:@grid)}.to eq([[nil, nil, nil, nil, nil, nil, nil],            
                                                                                            [nil, nil, nil, nil, nil, nil, nil],            
                                                                                            [nil, nil, nil, nil, nil, nil, nil],            
                                                                                            [nil, nil, nil, nil, nil, nil, nil],            
                                                                                            [nil, nil, nil, nil, nil, nil, nil],            
                                                                                            [nil, nil, nil, nil, 'A', nil, nil]])
            end  
        end

        context 'when a column is not empty' do
            before do
                game.instance_variable_set(:@grid,[[nil, nil, nil, nil, nil, nil, nil],            
                                                    [nil, nil, nil, nil, nil, nil, nil],            
                                                    [nil, nil, nil, nil, nil, nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'A', nil, nil]])
                allow(game).to receive(:gets).and_return("5\n")
                game.instance_variable_set(:@current_player,'A')
                allow(game).to receive(:puts).and_return(nil)
                
            end
            it 'sets the the first nil value in the row equal to @current_player' do
            expect{game.make_move}.to change{game.instance_variable_get(:@grid)}.to eq([[nil, nil, nil, nil, nil, nil, nil],            
                                                                                        [nil, nil, nil, nil, nil, nil, nil],            
                                                                                        [nil, nil, nil, nil, 'A', nil, nil],            
                                                                                        [nil, nil, nil, nil, 'B', nil, nil],            
                                                                                        [nil, nil, nil, nil, 'B', nil, nil],            
                                                                                        [nil, nil, nil, nil, 'A', nil, nil]])
            end
        end

        context 'when a column is full' do
            before do
                game.instance_variable_set(:@grid,[[nil, nil, nil, nil, 'A', nil, nil],            
                                                    [nil, nil, nil, nil, 'A', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'A', nil, nil]])
                allow(game).to receive(:gets).and_return("5\n","3\n")
                game.instance_variable_set(:@current_player,'A')
                allow(game).to receive(:puts).and_return(nil)
            end
            it 'puts message and gets input again' do
                expect(game).to receive(:gets).twice
            end
        end
    end

    describe '#check_win' do
        subject(:game){ConnectFour.new()} 
        context 'when four values in a row are equal' do
            before do
                game.instance_variable_set(:@grid,[[nil, nil, nil, nil, 'A', nil, nil],            
                                                    [nil, nil, nil, nil, 'A', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, nil, nil, nil, 'B', nil, nil],            
                                                    [nil, 'A', 'A', 'A', 'A', nil, nil]])

            end
            it 'sets @win to true' do
                expect{game.check_win}.to change{game.instance_variable_get(:@win)}.to eq(true)
            end
        end
        context 'when four values in a column are equal' do
            before do
                    game.instance_variable_set(:@grid,[[nil, nil, nil, nil, nil, nil, nil],            
                                                        [nil, nil, nil, nil, nil, nil, nil],            
                                                        [nil, nil, nil, nil, 'B', nil, nil],            
                                                        [nil, nil, nil, nil, 'B', nil, nil],            
                                                        [nil, nil, nil, nil, 'B', nil, nil],            
                                                        [nil, nil, nil, nil, 'B', nil, nil]])
            end
            it 'sets @win to true' do
                expect{game.check_win}.to change{game.instance_variable_get(:@win)}.to eq(true)

            end

        end
        context 'when four values in a digaonal are equal' do
            before do
                game.instance_variable_set(:@grid,[[nil, nil, nil, nil, nil, nil, nil],            
                                                    [nil, nil, nil, nil, nil, nil, nil],            
                                                    [nil, nil, nil, nil, 'A', nil, nil],            
                                                    [nil, nil, nil, 'A', nil, nil, nil],            
                                                    [nil, nil, 'A', nil, nil, nil, nil],            
                                                    [nil, 'A', nil, nil, nil, nil, nil]])
                end
                it 'sets @win to true' do
                    expect{game.check_win}.to change{game.instance_variable_get(:@win)}.to eq(true)
                end          
        end
        context 'when there are no 4 values in a line' do
            before do
                game.instance_variable_set(:@grid,[['A', 'A', 'B', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'B', 'B', 'A', 'B', 'A', 'B'],            
                                                    ['B', 'A', 'A', 'B', 'A', 'A', 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])
            end
            it 'does not set @win to true' do
                expect{game.check_win}.not_to change{game.instance_variable_get(:@win)}
            end
        end
    end

    describe '#check_draw' do
        subject(:game){ConnectFour.new()} 
        context 'when grid is full' do
            before do
                game.instance_variable_set(:@grid,[['A', 'A', 'B', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'B', 'B', 'A', 'B', 'A', 'B'],            
                                                    ['B', 'A', 'A', 'B', 'A', 'A', 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])

            end
            it 'returns true' do
                expect(game).to receive(:check_draw).and_return(true)
            end
        end
        context 'when four in a line is no possbility' do
            before do
                game.instance_variable_set(:@grid,[[nil, 'A', nil, 'B', nil, 'A', 'B'],            
                                                    [nil, 'B', 'B', 'A', 'B', 'A', 'B'],            
                                                    ['B', 'A', 'A', 'B', 'A', 'A', 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])
            end
            it 'returns true' do
                expect(game).to receive(:check_draw).and_return(true)
            end
        end
        context 'when there are enough empty values' do
            before do
                game.instance_variable_set(:@grid,[[nil, nil, nil, nil, nil, nil, 'B'],            
                                                    [nil, nil, nil, nil, nil, nil, 'B'],            
                                                    ['B', 'A', 'A', nil, 'A', nil, 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])
            end
            it 'returns false' do
                expect(game).to receive(:check_draw).and_return(true)
            end
        end
        
    end

    describe '#game_loop' do
        subject(:game){ConnectFour.new()} 
        context 'when @win is equal to true' do
            before do
                game.instance_variable_set(:@win,true)
                allow(game).to receive(:make_move).and_return(nil)
                allow(game).to receive(:check_draw).and_return(false)
                allow(game).to receive(:check_win).and_return(nil)
            end
            it 'iterates through the block one time' do
                expect(game).to receive(:make_move).twice
            end
        end
        context 'when check_draw returns true' do
            before do
                game.instance_variable_set(:@win,true)
                allow(game).to receive(:make_move).and_return(nil)
                allow(game).to receive(:check_draw).and_return(true)
                allow(game).to receive(:check_win).and_return(nil)
            end
            it 'iterates through the block one time' do
                expect(game).to receive(:make_move).twice
            end
        end 
    end
end
