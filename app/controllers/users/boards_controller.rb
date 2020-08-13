class Users::BoardsController < ApplicationController

    before_action :authenticate_user!

    def new
        @board = Board.new
        @board.tags.build
    end
    
    def index
        @boards = Board.page(params[:page]).reverse_order.includes(:user)
    end

    #Userモデルでhas many throughを定義したことにより、current_user.bookmark_boardsでデータを取得できる。
    def bookmark
        @boards = current_user.bookmark_boards.includes(:user)
    end

    def tag
        @ids = BoardTag.joins(:tag).where("tags.name=?",params[:tag]).pluck(:board_id)
        @boards = Board.find(@ids)
    end

    def show
        @board = Board.find(params[:id])
        @board_comment = BoardComment.new
	    @board_comments = @board.board_comments
        @boards = Board.all
        @tags = @board.tags
        # @users = @board.board_comments.users
    end

    def create
        @board = current_user.boards.build(board_params)
        # do |board|
        tags = params[:board][:tag_list][:name].split(",")
        #     tags.each do |tag|
        #         board.tags.buildfind_or_initialize_by(name: tag)
        #     end
        # end
        if tags.size > 5
            flash[:notice] = "タグ設定は５個以下でお願い致します。"
            redirect_to new_users_board_path
            return
        end
        if  @board.save
            @board.save_tags(tags)
            flash[:success] = "記事を作成しました"
            redirect_to users_board_path(@board.id)
        else
          # @board = current_user.boards.build(board_params)
          render 'users/boards/new'
        end
      end
      
      def edit
        @board= Board.find(params[:id])
      end
      
      # 編集は予定未実装
      # def update
      #   @board= Board.find(params[:id])
      #   tag_list = params[:tag_list].split(",")
      #   if @board.update_attributes(board_params)
      #       @board.save_tags(tag_list)
      #       flash[:success] = "記事を更新しました"
      #       redirect_to users_board_path(@board.id)
      #   else
      #     render 
      #   end
      # end
    
      def destroy
        @board = Board.find(params[:id])
        @board.destroy
        redirect_to root_path
      end

    private
    def board_params
        params.require(:board).permit(:user_id, :introduction, :title, :image)
    end

end