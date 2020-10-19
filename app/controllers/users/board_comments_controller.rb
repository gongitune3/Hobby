class Users::BoardCommentsController < ApplicationController

    def create
        @board = Board.find(params[:board_id])
        @board_new = Board.new
        @board_comment = @board.board_comments.new(board_comment_params)
        @board_comment.user_id = current_user.id
        unless @board_comment.save
            @board_comment = BoardComment.new
            @board_comments = @board.board_comments
            @boards = Board.all
            @tags = @board.tags
            flash[:notice] = "空欄及び、100字以上の投稿はできません。。。"
            redirect_to users_board_path(params[:board_id])
        end
    end

    def destroy
        @board_comment = BoardComment.find(params[:id])
        @board = Board.find(@board_comment.board.id)
        @board_comment.destroy
    end

    private
    
      def board_comment_params
        params.require(:board_comment).permit(:comment)
      end
end
