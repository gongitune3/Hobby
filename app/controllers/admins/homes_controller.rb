class Admins::HomesController < ApplicationController

    def top
        @day_contact = Contact.where(create_at: Day.today)
    end

end