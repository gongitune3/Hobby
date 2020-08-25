class Admins::BoardsController < ApplicationController

      def index
            @boards = Board.all.order(created_at: :desc)
      end

      def edit
            
      end
end
