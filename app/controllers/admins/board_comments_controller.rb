class Admins::BoardCommentsController < ApplicationController

      def destroy
            @board_comment = BoardComment.find(params[:id])
            @board.destroy
      end

      def create
      end
end
