class SessionsController < ApplicationController
  # Required to prevent session from resetting, due to use of 'def protect_from_forgery? false' in stk_mailer_helper
  # TODO: Figure out how to remove this line!
  skip_before_filter :verify_authenticity_token

  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      # Create an error message and re-render the signin form.
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      # Sign the user in and redirect to the requested page.
      sign_in user
      if session[:answer]
        # User just signed in after answering a stack
        @answer  = current_user.answers.build(session[:answer])
        session[:answer] = nil
        if @answer.save
          redirect_to stack_path(@answer.stack_id)
        else
          render 'pages/home'
        end          
      else
        redirect_back_or user
      end
    end
  end
    
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
