class Admins::HomesController < ApplicationController

    def top
        day_contact = Contact.where(create_at: Time.current)
    end
    
    
end
