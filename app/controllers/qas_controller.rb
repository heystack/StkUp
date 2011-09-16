class QasController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]

  def show
    @qa = Qa.find(params[:id])
    @stack = Stack.find(@qa.stack_id)
    @title = @qa.qa_desc
  end

  def new
    if signed_in?
      @stack = Stack.find(params[:stack_id])
      @qa = @stack.qas.new
      @title = "Link to a New Q&A"
    else
      flash[:notice] = "You must first sign in order to add a new Q&A."
      redirect_to root_path
    end
  end

  def create
    if signed_in?
      @stack = Stack.find(params[:stack_id])
      @qa = @stack.qas.new(params[:qa])
      if @qa.save
        flash[:success] = "Q&A Added!"
        redirect_to stack_path(@stack.id)
      else
        @title = "Link to a New Q&A"
        render 'new'
      end
    else
      flash[:notice] = "You must first sign in order to add a new Q&A."
      redirect_to root_path
    end
  end

  def destroy
    @qa = Qa.find(params[:id])
    @stack = Stack.find(@qa.stack_id)
    @qa.destroy
    flash[:success] = "Q&A deleted."
    redirect_to stack_path(@stack.id)
  end
    
end
