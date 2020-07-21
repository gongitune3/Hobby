class Users::UsersController < ApplicationController
    before_action :authenticate_user!
	before_action :screen_user, only: [:edit, :update]

    def show
        @user = User.find(params[:id])
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
