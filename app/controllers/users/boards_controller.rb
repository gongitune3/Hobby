class Users::BoardsController < ApplicationController

    def new
        @board = Board.new
    end
    
    def index
        @boards = Board.all
    end

    def show
        @board = Board.find(params[:id])
    end

    def create
        @board = Board.new(board_params)
        @board.user_id = current_user.id
        @board.save
        redirect_to users_board_path(@board.id)
    end
    
    
    private
    def board_params
        params.require(:board).permit(:user_id, :introduction, :title, :image)
    end

end