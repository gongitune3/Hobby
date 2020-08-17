class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_mail.subject
  #
  def contact_mail(contact)
    @contact = contact  
    mail to: 'e2rcsardanke@gmail.com', subject: "Hobby報告"
  end

end
