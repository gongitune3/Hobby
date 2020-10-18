class Admins::UsersController < ApplicationController

      def index
            @users = User.all
      end

      def show
            # ユーザーの直近コメント表示
            @user = User.find(params[:id])

            # ユーザーおすすめ機能→自身がコメントした板に紐づくタグと同様のタグをもつ板にコメントしているユーザーを取得する
            order_comment = @user.board_comments.order(created_at: :desc).limit(3)
            @order_boards = Board.where(id: order_comment.pluck(:board_id)).distinct
      end

end
