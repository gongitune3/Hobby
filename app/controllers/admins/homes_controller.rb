class Admins::HomesController < ApplicationController

    before_action :authenticate_admin!
    def top
        @day_contact = Contact.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
    end

end