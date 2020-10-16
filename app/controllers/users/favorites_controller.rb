class Users::FavoritesController < ApplicationController

    def create
        @board_comment = BoardComment.find(params[:board_comment_id])
        favorite = @board_comment.favorites.new(user_id: current_user.id)
        favorite.save
    end

    def destroy
        @board_comment = BoardComment.find(params[:board_comment_id])
        favorite = current_user.favorites.find_by(board_comment_id: params[:board_comment_id])
        favorite.destroy
    end

    #使用を考え中
    # private
    #     def redirect
    #     case params[:redirect_id].to_i
    #     when 0
    #         redirect_to _path
    #     when 1
    #         redirect_to _path
    #     end
    # end

end
