class Admins::BoardsController < ApplicationController

      def index
            @boards = Board.all.order(created_at: :desc)
      end

      def show
            @board = Board.find(params[:id])
            @boards = Board.all
            @tags = @board.tags
      end

      def tag
            @ids = BoardTag.joins(:tag).where("tags.name=?",params[:tag]).pluck(:board_id)
            @boards = Board.find(@ids)
      end

      def destroy
            board = Board.find(params[:id])
            if board.destroy
                  redirect_to admins_boards_path
            else
                  redirect_back(fallback_location: root_path)
            end
      end

end