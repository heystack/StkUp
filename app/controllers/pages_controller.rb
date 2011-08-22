class PagesController < ApplicationController

  def home
    @title = "Home"
    if signed_in?
      @answer = Answer.new
      # @answers = current_user.my_answers.all
      @grouped_answers = current_user.grouped_answers(1)
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

end
