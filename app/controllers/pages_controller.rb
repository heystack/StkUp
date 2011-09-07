class PagesController < ApplicationController

  def home
    @title = "Home"
    if signed_in?
      @answer = Answer.new
      # @answers = current_user.my_answers.all
      @answer_count = Answer.count
      @grouped_answers = current_user.grouped_answers(1) unless Answer.count == 0
      # @feed = current_user.feed.all
      # @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def contact_us_form
    # @contact_email = params[:contact_email]
    @contact = params[:contact]
    PageMailer.contact_us_email(@contact).deliver
    flash[:success] = "Thanks for contacting us! We'll get back to you shortly."
    redirect_to root_path
  end

end
