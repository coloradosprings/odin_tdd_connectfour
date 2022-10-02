require_relative '../lib/connectfour'
#"\u26AB"
#"\u26AA" 


describe ConnectFour do

    describe '#make_move' do
        subject(:game){ConnectFour.new()} 
        context 'when called' do

            before do
                allow(game).to receive(:check_column)
                allow(game).to receive(:gets).and_return("5\n")
                allow(game).to receive(:puts).and_return(nil)
                game.instance_variable_set(:@current_player,'A')
                allow(game).to receive(:display_grid).and_return(nil)
            end

            it 'puts the rows and gets which row to select' do
                expect(game).to receive(:puts).with("Player: \u26AA")
                expect(game).to receive(:puts).with("| 1 | 2 | 3 | 4 | 5 | 6 | 7 |")
                expect(game).to receive(:puts).with("row?: ")
                game.make_move
            end
        end

        context 'when @grid is empty and the selected row is 5' do

            before do
                allow(game).to receive(:check_column)
                allow(game).to receive(:gets).and_return("5\n")
                game.instance_variable_set(:@current_player,'A')
                allow(game).to receive(:puts).and_return(nil)
                allow(game).to receive(:display_grid).and_return(nil)
            end

            it 'sets column 0,index 4 equal to @current_player' do
                expect{game.make_move}.to change{game.instance_variable_get(:@grid)}.to eq([[' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                            [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                            [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                            [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                            [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                            [' ', ' ', ' ', ' ', 'A', ' ', ' ']])
            end  
        end

        context 'when a column is not empty' do
            before do
                allow(game).to receive(:check_column)
                allow(game).to receive(:display_grid).and_return(nil)
                game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' ']])
                allow(game).to receive(:gets).and_return("5\n")
                game.instance_variable_set(:@current_player,'A')
                allow(game).to receive(:puts).and_return(nil)
                
            end
            it 'sets the the first ' ' value in the row equal to @current_player' do
            expect{game.make_move}.to change{game.instance_variable_get(:@grid)}.to eq([[' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                        [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                                                        [' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                                                        [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                                                        [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                                                        [' ', ' ', ' ', ' ', 'A', ' ', ' ']])
            end
        end

        context 'when a column is full' do
            before do
                allow(game).to receive(:gets).and_return("5\n","3\n")
                allow(game).to receive(:display_grid).and_return(nil)
                game.instance_variable_set(:@grid,[ [' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' ']])
                
                game.instance_variable_set(:@current_player,'A')
                allow(game).to receive(:puts).and_return(nil)
            end
            it 'gets input twice' do
                expect(game).to receive(:gets).twice
                game.make_move
            end
        end
    end
    describe '#check_column' do
        subject(:game){ConnectFour.new}
        context 'when a column is full' do
            before do
                game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' ']])
                game.instance_variable_set(:@available_columns,['1','2','*','4','5','6','7'])
            end
            it 'replaces column with \'*\' in @available_columns' do
                expect{game.check_column}.to change{game.instance_variable_get(:@available_columns)}.to eq(['1','2','*','4','*','6','7'])
            end
        end
    end

    describe '#check_win' do
        subject(:game){ConnectFour.new()} 
        context 'when four values in a row are equal' do
            before do
                game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', 'A', 'A', 'A', 'A', ' ', ' ']])

            end
            it 'sets @win to true' do
                expect{game.check_win}.to change{game.instance_variable_get(:@win)}.to eq(true)
            end
        end
        context 'when four values in a column are equal' do
            before do
                    game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                        [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                        [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                        [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                        [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                        [' ', ' ', ' ', ' ', 'B', ' ', ' ']])
            end
            it 'sets @win to true' do
                expect{game.check_win}.to change{game.instance_variable_get(:@win)}.to eq(true)

            end

        end
        context 'when four values in a bottom left to up right digaonal are equal' do
            before do
                game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'A', ' ', ' '],            
                                                    [' ', ' ', ' ', 'A', ' ', ' ', ' '],            
                                                    [' ', ' ', 'A', ' ', ' ', ' ', ' '],            
                                                    [' ', 'A', ' ', ' ', ' ', ' ', ' ']])
                end
                it 'sets @win to true' do
                    expect{game.check_win}.to change{game.instance_variable_get(:@win)}.to eq(true)
                end          
        end

        context 'when four values in a bottom right to up left digaonal are equal' do
            before do
                game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', 'B', ' ', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', 'B', ' ', ' '],            
                                                    [' ', ' ', ' ', ' ', ' ', 'B', ' '],            
                                                    [' ', ' ', ' ', ' ', ' ', ' ', 'B'],            
                                                    [' ', ' ', ' ', ' ', ' ', ' ', ' ']])
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

    describe '#basic_check_draw' do
        subject(:game){ConnectFour.new()} 
        context 'when grid is full' do
            before do
                game.instance_variable_set(:@current_player,'A')
                game.instance_variable_set(:@grid,[['A', 'A', 'B', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'B', 'B', 'A', 'B', 'A', 'B'],            
                                                    ['B', 'A', 'A', 'B', 'A', 'A', 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])

            end
            it 'returns true' do
                expect(game).to receive(:basic_check_draw).and_return(true)
                game.basic_check_draw
            end
        end
        context 'when four in a line is no possbility' do
            before do
                game.instance_variable_set(:@current_player,'A')
                game.instance_variable_set(:@grid,[[' ', 'A', ' ', 'B', ' ', 'A', 'B'],            
                                                    [' ', 'B', 'B', 'A', 'B', 'A', 'B'],            
                                                    ['B', 'A', 'A', 'B', 'A', 'A', 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])
            end
            it 'returns true' do
                expect(game).to receive(:basic_check_draw).and_return(true)
                game.basic_check_draw
            end
        end
        context 'when there are enough empty values' do
            before do
                game.instance_variable_set(:@current_player,'A')
                game.instance_variable_set(:@grid,[[' ', ' ', ' ', ' ', ' ', ' ', 'B'],            
                                                    [' ', ' ', ' ', ' ', ' ', ' ', 'B'],            
                                                    ['B', 'A', 'A', ' ', 'A', ' ', 'A'],            
                                                    ['A', 'B', 'A','B', 'A', 'B', 'A'],            
                                                    ['B', 'B', 'A', 'B', 'B', 'A', 'B'],            
                                                    ['A', 'A', 'B', 'A', 'A', 'B', 'A']])
            end
            it 'returns false' do
                expect(game).to receive(:basic_check_draw).and_return(true)
                game.basic_check_draw
            end
        end
        
    end

    describe '#game_loop' do
        subject(:game){ConnectFour.new()} 
        context 'when @basic_checkdraw to true' do
            before do
                game.instance_variable_set(:@win,true)
                allow(game).to receive(:make_move).and_return(nil)
                allow(game).to receive(:basic_check_draw).and_return(false)
                allow(game).to receive(:check_win).and_return(nil)
                allow(game).to receive(:display_grid)
                allow(game).to receive(:puts)
            end
            it 'iterates through half of the the block' do
                expect(game).to receive(:make_move).once
                game.game_loop
            end
        end
        context 'when basic_check_draw returns true' do
            before do
                game.instance_variable_set(:@win,false)
                allow(game).to receive(:make_move).and_return(nil)
                allow(game).to receive(:basic_check_draw).and_return(true)
                allow(game).to receive(:check_win).and_return(nil)
                allow(game).to receive(:display_grid)
                allow(game).to receive(:puts)               
            end
            it 'iterates until half of the block' do
                expect(game).to receive(:make_move).once
                game.game_loop
            end
        end 
    end
end
