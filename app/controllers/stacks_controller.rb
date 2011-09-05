class StacksController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :admin_user,   :only => :destroy
    
  def index
    @title = "Stacks"
    @stacks = Stack.paginate(:page => params[:page])
  end

  def show
    @stack = Stack.find(params[:id])
    @interest = Interest.find(@stack.interest_id)
    @title = @stack.question
    @choices = @stack.choices
    @answers = @stack.answers
  end

  def new
    if signed_in?
      @interest = Interest.find(params[:interest_id])
      @stack = @interest.stacks.new
      @title = "Create a New Stack"
    else
      flash[:notice] = "You must first sign in order to create a new Stack."
      redirect_to root_path
    end
  end

  def create
    if signed_in?
      @interest = Interest.find(params[:interest_id])
      @stack = @interest.stacks.new(params[:stack])
      if @stack.save
        flash[:success] = "Stack Created!"
        redirect_to interests_path
      else
        @title = "Create a New Stack"
        render 'new'
      end
    else
      flash[:notice] = "You must first sign in order to create a new Stack."
      redirect_to root_path
    end
  end

  def destroy
    Stack.find(params[:id]).destroy
    flash[:success] = "Stack deleted."
    redirect_to interest_path
  end
    
end
