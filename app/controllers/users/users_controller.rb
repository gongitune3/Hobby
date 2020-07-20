class Users::UsersController < ApplicationController
    before_action :authenticate_user!
	before_action :screen_user, only: [:edit, :update]

    def show
        @user = User.find(params[:id])
    end
    
    private
	  	def user_params
		 	params.require(:user).permit(:nickname, :introduction, :profile_image)
	  	end
end
