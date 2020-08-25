class Admins::ContactsController < ApplicationController

  before_action :authenticate_admin!
  def index
    @contacts = Contact.all
  end
  
  def edit
    @contact = Contact.find(params[:id])
    @change_contact = Contact.new
  end

  def update
    @contat = Contact.find(params[:id])
      if @contat.update(contact_params)
          flash.now[:notice] = '更新完了'
          redirect_to admins_contacts_path
      else
          render 'admins/contacts/edit'
      end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :message, :type, :reply, :category, :status)
  end

end
