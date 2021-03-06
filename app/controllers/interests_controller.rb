class InterestsController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :admin_user,   :only => :destroy
    
  def index
    @title = "Stack Categories"
    @interests = Interest.paginate(:page => params[:page])
  end

  def show
    @interest = Interest.find(params[:id])
    @title = @interest.interest_desc
    @stacks = @interest.stacks
  end

  def edit
    @interest = Interest.find(params[:id])
    @title = @interest.interest_desc
    @stacks = @interest.stacks
  end

  def new
    if signed_in?
      @interest = Interest.new
      @title = "Create Stack Category"
    else
      flash[:notice] = "You must first sign in order to create a new Stack Category."
      redirect_to root_path
    end
  end

  def create
    if signed_in?
      @interest = Interest.new(params[:interest])
      if @interest.save
        flash[:success] = "Stack Category Created!"
        redirect_to interest_path(@interest.id)
      else
        @title = "Create Stack Category"
        render 'new'
      end
    else
      flash[:notice] = "You must first sign in order to create a new Stack Category."
      redirect_to root_path
    end
  end

  def update
    @interest = Interest.find(params[:id])
    if @interest.update_attributes(params[:interest])
      flash[:success] = "Stack Category Updated!"
      redirect_to interest_path(@interest.id)
    else
      @title = "Edit Stack Category"
      render 'edit'
    end
  end

  def destroy
    Interest.find(params[:id]).destroy
    flash[:success] = "Stack Category deleted."
    redirect_to interests_path
  end
    
end
