class StkMailer < ActionMailer::Base
  default :from => "sbrown@stkup.com"

  def welcome_email(user)
    @user = user
    @url  = "http://www.stkup.com/login"
    mail(:to => user.email, :subject => "Welcome to StkUp!")
  end
end
