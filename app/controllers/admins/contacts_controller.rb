class Admins::ContactsController < ApplicationController

  before_action :authenticate_admin!
  def index
    @contacts = Contact.all
  end
  
end
