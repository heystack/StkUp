class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  # Required to prevent session from resetting, due to use of 'def protect_from_forgery? false' in stk_mailer_helper 
  skip_before_filter :verify_authenticity_token

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    if session[:answer]
      # User just signed in after answering a stack - no longer used
      @answer  = current_user.answers.build(session[:answer])
      session[:answer] = nil
      if @answer.save
        redirect_to stack_path(@answer.stack_id)
      else
        render 'pages/home'
      end
    else
      @answers = @user.answers.paginate(:page => params[:page])
      @user_interests = @user.user_interests
      @title = @user.name
    end
  end

  def new
    if signed_in?
      flash[:notice] = "You must first sign out in order to create a new user."
      redirect_to root_path
    else
      @user = User.new
      @title = "Sign up"
    end
  end

  def create
    if signed_in?
        flash[:notice] = "You must first sign out in order to create a new user."
        redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to StkUp!"
        # Tell the UserMailer to send a welcome Email after save
        UserMailer.welcome_email(@user).deliver
        if session[:answer]
          # User just signed up after answering a stack
          @answer  = current_user.answers.build(session[:answer])
          session[:answer] = nil
          if @answer.save
            redirect_to stack_path(@answer.stack_id)
          else
            @feed_items = []
            render 'pages/home'
          end          
        else
          redirect_to @user
        end
      else
        @title = "Sign up"
        render 'new'
      end
    end
  end
  
  def edit
    @title = "Edit user"
    @user_interests = @user.user_interests
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
    flash[:success] = "Admin toggled."
    respond_to do |format|
      # redirect_to does not seem to be working, so used document.location in toggle_admin.js.erb...seems messy
      format.html { redirect_to "www.google.com" }
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
