class AnswersController < ApplicationController
  # Removed before_filter :create for creating new answers upon user signup
  # before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authenticate, :only => [:destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    if signed_in?
      @answer  = current_user.answers.build(params[:answer])
      # Follow the category
      @stack = Stack.find(params[:answer][:stack_id])
      @interest = @stack.interest
      if !current_user.interested_in?(@interest)
        current_user.interested_in!(@interest)
      end
      if @answer.save
        flash[:success] = "Answer created!"
        redirect_to stack_path(@answer.stack_id)
      else
        @feed_items = []
        render 'pages/home'
      end
    else
      session[:answer] = params[:answer]
      redirect_to signup_path      
    end
  end

  def destroy
    @answer.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      @answer = current_user.answers.find_by_id(params[:id])
      redirect_to root_path if @answer.nil?
    end

end

