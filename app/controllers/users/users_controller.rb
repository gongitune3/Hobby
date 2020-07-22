class Users::UsersController < ApplicationController
    before_action :authenticate_user!
	before_action :screen_user, only: [:edit, :update]

    def show
        
        @user = User.find(params[:id])
        #ユーザーおすすめ機能、カレントユーザーのコメントを取得
        
        # 自分のコメントを取得
        comments = @user.board_comments
        # 自分がコメントしたボードのidを取得
        # boards = Board.find(comments.pluck(:board_id).uniq)
        boards = Board.where(id: comments.pluck(:board_id))
        
        # 自分がコメントしたボードのidから中間テーブルを参照し、紐づくタグのidを取得これに合致する複数のboard_idを取得。
        # board_ids = BoardTag.where(tag_id: boards.board_tags.pluck(:tag_id).pluck(:board_id)
        byebug
        tag_ids = []
        boards.each do |board|
            board.board_tags.each do |board_tag|
                tag_ids << board_tag.tag_id
                #tag_ids.push(board_tag.id)
            end
        end
        #[1,2,3]
        # board_tags = BoardTag.where(tag_id: boards.board_tags.pluck(:tag_id))
        #board_tags = BoardTag.where(tag_id: tag_ids.uniq)

        #
        board_ids = board_tags.pluck(:board_id)
        # そこに紐づくコメントしているユーザーを取ってきたい
        byebug
        # @Recommended
    end
    
    def index
        @users = User.page(params[:page]).reverse_order
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to users_user_path(@user), notice: "更新完了"
        else
            @user = User.find(params[:id])
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
