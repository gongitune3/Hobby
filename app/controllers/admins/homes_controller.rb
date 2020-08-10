class Admins::HomesController < ApplicationController

    before_action :authenticate_admins!

    def top
        
    end
    
end
