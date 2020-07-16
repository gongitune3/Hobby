class Users::BoardsController < ApplicationController

    def new
        @board = Board.new
    end
    

    def create
        @board = Board.new(board_params)
        @board.save
        redirect_to @board
        tag_list = params[:tag_name].split(",")
        if  @board.save
            @board.save_ boards(tag_list)
        end
    end
    
    
    private
    def board_params
        params.require(:board).permit(:user_id, :introduction, :title, :image)
    end

end