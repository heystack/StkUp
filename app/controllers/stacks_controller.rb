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
    @answer = @stack.answers.new
    # This version of @grouped_answers gives the count by choice_id, instead of choice_text 
    # @grouped_answers = current_user.grouped_answers(@stack.id) unless @stack.answers.count == 0
    # This UGLY code gives @grouped_answers count by choice_text
    # TODO: Clean this up...maybe store choice_text directly in the Answer model?
    if @stack.answers.count > 0
      @grouped_answers_with_id = current_user.grouped_answers(@stack.id)
      @grouped_answers = Array.new
      @grouped_answers_with_id.map { |a| @grouped_answers << [Choice.find_by_id(a[0].to_i).choice_text, a[1]] }
    end
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
        redirect_to interest_path(@interest.id)
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
