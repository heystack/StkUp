class StkMailer < ActionMailer::Base
  default :from => "sbrown@stkup.com"

  def welcome_email(user)
    @user = user
    @url  = "http://stkup-alpha.heroku.com/signin"
    mail(:to => user.email, :subject => "Welcome to StkUp!")
  end

  def send_stack_test(contact, stack)
    @contact = contact
    @stack = stack
    @choices = @stack.choices
    @answers = @stack.answers
    @answer = @stack.answers.new
    mail(:to => contact[:email], :subject => "Daily Stack!")
  end

end
