class Admins::ContactsController < ApplicationController

  before_action :authenticate_admin!
  def index
    # @contacts = Contact.page(params[:page]).per(PER).order(created_at: :desc)
    @contacts = Contact.all.order(created_at: :desc)
  end
  
  def edit
    @contact = Contact.find(params[:id])
    @change_contact = Contact.new
  end


  def update
    @contat = Contact.find(params[:id])
      if @contat.update(contact_params)
          flash[:notice]= '更新完了'
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
