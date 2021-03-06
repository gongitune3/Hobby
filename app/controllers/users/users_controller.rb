class Users::UsersController < ApplicationController
    before_action :authenticate_user!
	before_action :screen_user, only: [:edit, :update]

    def show
        @user = User.find(params[:id])
        if @user.profile_image_id.present?
            @image_url = "https://hobby3ch-files-resize.s3-ap-northeast-1.amazonaws.com/store/" + @user.profile_image_id + "-thumbnail."
        else
            # helpers.←view側のヘルパーメソッドが使える
            @image_url = helpers.image_path("no_image.jpg");
        end

        order_comment = @user.board_comments.order(created_at: :desc).limit(3)
        @order_boards = Board.where(id: order_comment.pluck(:board_id)).distinct

        # 以下・ユーザーおすすめ機能、自身がコメントした板に紐づくタグと同様のタグをもつ板にコメントしているユーザーを取得する
        # 1/自分のコメントを取得
        comments = @user.board_comments
        # 2/自分がコメントした板の情報をコメントのidを元に取得
        boards = Board.where(id: comments.pluck(:board_id)).distinct
        # 3/自分がコメントしたボードのidから中間テーブルを参照しtag_idsを定義し配列に代入？紐づくタグidを取得。
        # board_ids = BoardTag.where(tag_id: boards.board_tags.pluck(:tag_id).pluck(:board_id))←boardsがレコードで来ている為使えない。
        tag_ids = []
        boards.each do |board|
            board.board_tags.each do |board_tag|
                tag_ids << board_tag.tag_id
                #tag_ids.push(board_tag.id)
            end
        end
        board_tags = BoardTag.where(tag_id: tag_ids).distinct
        # 5/ 4を行った上で関連している板のidを検索。
        board_ids = board_tags.pluck(:board_id).uniq
        # //自分を例外にする処理
        user_comments_ids = []
        current_user.board_comments.each do |user|
            user_comments_ids << user.id
        end
        # 6/ 上記で取得してきたidを持っているコメントを抽出
        board_comments = BoardComment.where.not(id: user_comments_ids).where(board_id: board_ids)
        # 7/ コメントからユーザーの情報を取得
        users = []
        board_comments.each do |board_comment|
            users << board_comment.user
        end
        @recommended = users.uniq.shuffle.take(3)
        if @user.profile_image_id.present?
            @image_url = "https://hobby3ch-files-resize.s3-ap-northeast-1.amazonaws.com/store/" + @user.profile_image_id + "-thumbnail."
        else
            # helpers.←view側のヘルパーメソッドが使える
            @image_url = helpers.image_path("no_image.jpg");
        end
    end

    def index
        @users = User.page(params[:page]).reverse_order
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        # 本番環境と開発環境でアップデートを切り分ける方法
        if @user.update(user_params)
            sleep(3)
            flash.now[:notice] = '更新完了'
            redirect_to users_user_path(@user)
        else
            render 'users/users/edit'
        end
    end

    private
	    def user_params
		 	params.require(:user).permit(:nickname, :introduction, :profile_image)
        end

        def screen_user
			unless params[:id].to_i == current_user.id
		  		redirect_to user_path(current_user)
            end
        end
end
