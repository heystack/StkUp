class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
    
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    if signed_in?
      flash[:notice] = "You must first sign out order to create a new user."
      redirect_to root_path
    else
      @user = User.new
      @title = "Sign up"
    end
  end

  def create
    if signed_in?
        flash[:notice] = "You must first sign out order to create a new user."
        redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        @title = "Sign up"
        render 'new'
      end
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    # redirect_to does not seem to be working, so no flash
    # flash[:success] = "Admin toggled."
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def interests
    @title = "Interests"
    @user = User.find(params[:id])
    @interests = @user.interests.paginate(:page => params[:page])
    render 'show_interests'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    # Moved to sessions_helper.rb
    # def admin_user
    #   redirect_to(root_path) unless current_user.admin?
    # end
  
end
