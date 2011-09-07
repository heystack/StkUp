class PageMailer < ActionMailer::Base
  default :from => "sbrown@stkup.com"

  def contact_us_email(contact)
    @contact = contact
    mail(:to => "nycbrown@gmail.com", :subject => "Thanks for contacting StkUp!")
  end
end
