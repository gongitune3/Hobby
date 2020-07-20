class Users::FavoritesController < ApplicationController
    def create
        @comment = BoardComment.find(params[:board_comment_id])
        favorite = @comment.favorites.new(user_id: current_user.id)
        favorite.save
        redirect_to request.referer
    end
    
    def destroy
        favorite = current_user.favorites.find_by(id: params[:id])
        favorite.destroy
        redirect_to request.referer
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
