class Users::BoardsController < ApplicationController

    def new
        @board = Board.new
    end
    

    def create
        @board = Board.new(board_params)
        @board.save
        redirect_to("/")
        tag_list = params[:tag_name].split(",")
        if  @post.save
            @post.save_posts(tag_list)
        end
    end
    
    
    private
    def board_params
        params.require(:board).permit(:user_id, :introduction, :title, :image)
    end

end