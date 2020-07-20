class Users::BoardsController < ApplicationController

    def new
        @board = Board.new
        @board.tags.build
    end
    
    def index
        @boards = Board.page(params[:page]).reverse_order.includes(:user)
    end

    def bookmarks
        @boards = current_user.bookmark_boards.includes(:user)
    end

    def show
        @board = Board.find(params[:id])
        @board_comment = BoardComment.new
	      @board_comments = @board.board_comments
        @boards = Board.all
        @tags = @board.tags
    end

    # def create
    #     @board = Board.new(board_params)
    #     @board.user_id = current_user.id
    #     @board.save
    #     redirect_to users_board_path(@board.id)
    # end
    
    def create
        @board= current_user.boards.build(board_params)
        tags = params[:board][:tag_list][:name].split(",")

        if @board.save
            @board.save_tags(tags)
            flash[:success] = "記事を作成しました"
            redirect_to users_board_path(@board.id)
        else
          render root_path
        end
      end
      
      def edit
        @board= Board.find(params[:id])
        @tag_list = @board.tag.pluck(:name).join(",")
      end
      
      def update
        @board= Board.find(params[:id])
        tag_list = params[:tag_list].split(",")
        if @board.update_attributes(board_params)
            @board.save_tags(tag_list)
            flash[:success] = "記事を更新しました"
            redirect_to users_board_path(@board.id)
        else
          render 
        end

      end
    
    private
    def board_params
        params.require(:board).permit(:user_id, :introduction, :title, :image)
    end

end