class Users::BookmarksController < ApplicationController
    def create
        bookmark = current_user.bookmarks.build(board_id: params[:board_id])
        bookmark.save
        # redirect_to request.referer
        redirect_back(fallback_location: root_path)
    end

    def destroy
        bookmark = current_user.bookmarks.find_by(board_id: params[:board_id])
        bookmark.destroy
        # redirect_to request.referer
        redirect_back(fallback_location: root_path)
    end

    def index
        # @board = Board.find(params[:id])
        # @bookmarks = @board.bookmarks
    end
end
