class Users::BoardCommentsController < ApplicationController

    def create
        @board = Board.find(params[:board_id])
        @board_new = Board.new
        @board_comment = @board.board_comments.new(board_comment_params)
        @board_comment.user_id = current_user.id
        if @board_comment.save
            flash[:success] = "Comment was successfully created."
            redirect_to users_board_path(@board)
        else
            @board_comment = BoardComment.new
	        @board_comments = @board.board_comments
            @boards = Board.all
            @tags = @board.tags
            render 'users/boards/show'
        end
    end
    
    def destroy
        board_comment = BoardComment.find(params[:id])
        board_comment.destroy
        redirect_to request.referer
    end

    private
    
      def board_comment_params
        params.require(:board_comment).permit(:comment)
      end
end
