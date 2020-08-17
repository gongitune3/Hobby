class Users::ContactsController < ApplicationController

  def new
  logger.debug '======================================='
  logger.debug Rails.env
  logger.debug '======================================='
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      flash[:success] = 'お問い合わせを受け付けました'
      redirect_to root_path
    else
      @contact = Contact.new(contact_params)
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :message)
  end

end
