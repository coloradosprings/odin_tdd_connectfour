class ConnectFour
    def initialize
        @grid = Array.new(6){Array.new(7,' ')}
        @win = false
        @available_columns = ['1','2','3','4','5','6','7']
    end

    def check_column
        for x in 0..6
            if @grid.all?{|row| !(row[x] == ' ')}
                @available_columns[x] = '*'
            else
                next
            end
        end
    end

    def make_move
        if @current_player == 'A'
            puts "Player: \u26AA"
        else
            puts "Player: \u26AB"
        end
        check_column
        col = @available_columns
        display_grid
        puts "| #{col[0]} | #{col[1]} | #{col[2]} | #{col[3]} | #{col[4]} | #{col[5]} | #{col[6]} |"
        puts "row?: "
        selection = nil
        loop do
        selection = gets.chomp
        break if col.include?(selection) && selection != '*'
        puts "row?: "
        end

        sel_column = selection.to_i - 1
        for x in 0..5
            x = 5 - x 
            if @grid[x][sel_column] == ' '
                @grid[x][sel_column] = @current_player
                break
            end 
        end
    end
    
    def check_win()
        @grid.each do |row|
            @win = true if (row.join).include?('AAAA') || (row.join).include?('BBBB')
        end

        for x in 0..6
            column = []
            for i in 0..5
                column.push(@grid[i][x])
            end
            @win = true if (column.join).include?('AAAA') || (column.join).include?('BBBB')
        end

        for x in 0..3
            diagonal = []
            for i in 0..5
                k = x + i
                break if k == 7
                diagonal.push(@grid[i][k])              
            end
            @win = true if (diagonal.join).include?('AAAA') || (diagonal.join).include?('BBBB')
        end

        for x in 0..3
            diagonal = []
            for i in 0..5
                k = x + i
                i = 5 - i               
                break if k == 7
                diagonal.push(@grid[i][k])              
            end
            @win = true if (diagonal.join).include?('AAAA') || (diagonal.join).include?('BBBB')
        end
    end

    def basic_check_draw
        return true if @available_columns == ['*','*','*','*','*','*','*']
        grid = Array.new(@grid)
        @grid = @grid.map{|row| row.map{|item| item == ' ' ?  item = @current_player : item = item}}
        check_win
        if @win == true
            @win = false
            @grid = grid
            return false
        else
            @grid = grid
            return true   
        end
    end

    def display_grid
        grid_display = @grid.map do |row| 
                                    row.map do |item|
                                        if item == 'A'
                                            item = "\u26AA"
                                        elsif item == 'B'
                                            item = "\u26AB"
                                        else
                                            item = '  '
                                        end
                                    end
                                end
        grid_display.each do |row| 
            print "|"
            row.each{|item| print " #{item}|"}
            print "\n"
        end
    end

    def game_loop
        loop do
            @current_player = 'A'
            make_move
            check_win
            if @win == true
                display_grid
                puts "Four in a row!"
                break
            end
            if basic_check_draw 
                display_grid
                print @grid
                puts "It\'s a draw!"
                break
            end
            @current_player = 'B'
            make_move
            check_win
            if @win == true
                display_grid
                puts "Four in a row!"
                break
            end
            if basic_check_draw 
                display_grid
                puts "It\'s a draw!"
                break
            end
        end
    end
end