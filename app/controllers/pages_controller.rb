class PagesController < ApplicationController

  def home
    @title = "Home"

    if Stack.count > 0
      @stack = Stack.first
      @interest = Interest.find(@stack.interest_id)
      @title = @stack.question
      @choices = @stack.choices
      @answers = @stack.answers
      @answer = @stack.answers.new
      # This version of @grouped_answers gives the count by choice_id, instead of choice_text 
      # @grouped_answers = current_user.grouped_answers(@stack.id) unless @stack.answers.count == 0
      # This UGLY code gives @grouped_answers count by choice_text
      # TODO: Clean this up...maybe store choice_text directly in the Answer model?
      if signed_in?
        if @stack.answers.count > 0
          @grouped_answers_with_id = current_user.grouped_answers(@stack.id)
          @grouped_answers = Array.new
          @grouped_answers_with_id.map { |a| @grouped_answers << [Choice.find_by_id(a[0].to_i).choice_text, a[1]] }
        end
      end
    end
    
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
