class ChoicesController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :admin_user,   :only => :destroy
    
  def index
    @title = "Choices"
    @choices = Choice.paginate(:page => params[:page])
  end

  def show
    @choice = Choice.find(params[:id])
    @stack = Stack.find(@choice.stack_id)
    @title = @choice.choice_text
    @all_choices = @stack.choices
  end

  def new
    if signed_in?
      @stack = Stack.find(params[:stack_id])
      @choice = @stack.choices.new
      @title = "Create a New Choice"
    else
      flash[:notice] = "You must first sign in order to create a new Choice."
      redirect_to root_path
    end
  end

  def create
    if signed_in?
      @stack = Stack.find(params[:stack_id])
      @choice = @stack.choices.new(params[:choice])
      if @choice.save
        flash[:success] = "Choice Created!"
        redirect_to stack_path(@stack.id)
      else
        @title = "Create a New Choice"
        render 'new'
      end
    else
      flash[:notice] = "You must first sign in order to create a new Choice."
      redirect_to root_path
    end
  end

  def destroy
    @choice = Choice.find(params[:id])
    @stack = Stack.find(@choice.stack_id)
    @choice.destroy
    flash[:success] = "Choice deleted."
    redirect_to stack_path(@stack.id)
  end
    
end
