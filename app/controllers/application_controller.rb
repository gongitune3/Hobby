class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_out_path_for(a) #ログアウトした時の遷移先
        if a == :admins
            new_admins_session_path
        else
            root_path
        end
    end

    def after_sign_in_path_for(resource) #ログインした時の遷移先
        case resource
        when Admin
            admins_root_path
        when User
            root_path
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :profile_image, :nickname, :introduction])
    end
end
