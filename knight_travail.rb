class GameBoard
    def initialize
    end

    def knight_moves(start_square, end_square)
        start = Square.new(start_square[0], start_square[1])
        finish = Square.new(end_square[0], end_square[1])

        queue = [start]

        if start_square[0] < 0 || start_square[0] > 7 || start_square[1] < 0 || start_square[1] > 7
            puts "Your starting square doesn't exist on the board!"
            return
        elsif end_square[0] < 0 || end_square[0] > 7 || end_square[1] < 0 || end_square[1] > 7
            puts "Your ending square doesn't exist on the board!"
            return
        end
        return "You're already on that square!" if start_square == end_square


        until queue.empty?
            element = queue.shift
            # Returns a matched node value to the search value
            break if element.coordinates == end_square
            # Adds each left and right child to the queue if not nil
            element.find_moves
            element.children.each do |child|
                child.parent = element
                queue << child
            end
        end
        result = []
        until element.nil?
            result.unshift(element.coordinates)
            element = element.parent
        end
        puts "You made it in #{result.length - 1} move#{ result.length - 1 > 1 ? 's' : ''}!"
        result
    end
end

class Square
    attr_reader :x, :y, :children, :coordinates
    attr_accessor :parent
    def initialize(x, y, parent = nil)
        @parent = parent
        @coordinates = [x, y]
        @x = x
        @y = y
        @children = []
    end

    # Get available knight moves from the current square
    def find_moves
        possibles = []
        possibles << [@x - 2, @y + 1] <<  [@x - 2, @y - 1] <<
                      [@x + 2, @y - 1] << [@x + 2, @y + 1] <<
                      [@x + 1, @y - 2] << [@x + 1, @y + 2] <<
                      [@x - 1, @y - 2]  << [@x - 1, @y + 2]
        # Checks if valid board square
        possibles.each do |x, y|
            added_square = Square.new(x, y, @parent)
            children << added_square if x <= 7 && x >= 0 && y <= 7 && y >= 0
        end
    end
end


board = GameBoard.new

p board.knight_moves([1,2], [3,5])
