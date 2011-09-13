class UserMailer < ActionMailer::Base
  default :from => "sbrown@stkup.com"

  def welcome_email(user)
    @user = user
    @url  = "http://stkup-alpha.heroku.com/signin"
    mail(:to => user.email, :subject => "Welcome to StkUp!")
  end

  def daily_email(user)
    @user = user
    mail(:to => user.email, :subject => "Your Daily Stack!")
  end
end
