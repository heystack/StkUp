class AnswersController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    if signed_in?
      @answer  = current_user.answers.build(params[:answer])
      if @answer.save
        flash[:success] = "Answer created!"
        redirect_to stack_path(@answer.stack_id)
      else
        @feed_items = []
        render 'pages/home'
      end
    else
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

