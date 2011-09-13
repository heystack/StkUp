class StacksController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
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
    @my_answers = @answers.find_all_by_user_id(current_user)
    if !@my_answers.empty?
      @my_last_choice = Choice.find(@my_answers.last.choice_id)
    end
    # This version of @grouped_answers gives the count by choice_id, instead of choice_text 
    # @grouped_answers = current_user.grouped_answers(@stack.id) unless @stack.answers.count == 0
    # This UGLY code gives @grouped_answers count by choice_text
    # TODO: Clean this up...maybe store choice_text directly in the Answer model?
    if @stack.answers.count > 0
      @grouped_answers_with_id = current_user.grouped_answers(@stack.id)
      @grouped_answers = Array.new
      # This may be the ugliest line of code I have ever written
      @grouped_answers_with_id.map { |a| @grouped_answers << [Choice.find_by_id(a[0].to_i).choice_text, a[1]] }
      if @my_last_choice
        # No, no...THIS may be the ugliest line of code I have ever written...
        # wish I could use @grouped_answers.rindex(@my_last_choice.choice_text),
        # but rindex matches to SECOND item, not FIRST
        @my_choice_index = @grouped_answers.flatten.index(@my_last_choice.choice_text) / 2
      end
    end
    @stack_creator = User.find_by_id(@stack.created_by)
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

  def send_stack_form
    @stack = Stack.find(params[:contact][:stack_id])
    @contact = params[:contact]
    StkMailer.send_stack_test(@contact, @stack).deliver
    flash[:success] = "Stack sent to #{@contact[:email]}."
    redirect_to stack_path(@stack)
  end
    
end
