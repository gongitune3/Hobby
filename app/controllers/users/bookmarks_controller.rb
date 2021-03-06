class Users::BookmarksController < ApplicationController

    def create
        @board = Board.find(params[:board_id])
        bookmark = current_user.bookmarks.build(board_id: params[:board_id])
        bookmark.save
        # redirect_to request.referer
    end

    def destroy
        @board = Board.find(params[:board_id])
        bookmark = current_user.bookmarks.find_by(board_id: params[:board_id])
        bookmark.destroy
        # redirect_to request.referer
    end

    def index
        # @board = Board.find(params[:id])
        # @bookmarks = @board.bookmarks
    end
end
