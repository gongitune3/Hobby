class Admins::BoardsController < ApplicationController

      def index
            @boards = Board.all.order(created_at: :desc)
      end

      def show
            @board = Board.find(params[:id])
      end
end
