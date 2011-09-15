class PagesController < ApplicationController

  def home
    @title = "Home"

    if Stack.count > 0
      @stack = Stack.random
      @interest = Interest.find(@stack.interest_id)
      @choices = @stack.choices
      @answer = @stack.answers.new
      # This version of @grouped_answers gives the count by choice_id, instead of choice_text 
      # @grouped_answers = current_user.grouped_answers(@stack.id) unless @stack.answers.count == 0
      # This UGLY code gives @grouped_answers count by choice_text
      # TODO: Clean this up...maybe store choice_text directly in the Answer model?
      if signed_in?
        @my_answers = Answer.find_all_by_user_id(current_user)
        @my_stack_ids = Array.new
        @my_answers.map { |a| @my_stack_ids << a.stack_id }
        @my_stacks = Stack.find(:all, :conditions=> { :id => @my_stack_ids })
        if !@my_answers.empty?
          @my_last_choice = Choice.find(@my_answers.last.choice_id)
        end
      end
    else
      if signed_in?
        @answer = Answer.new
        # @answers = current_user.my_answers.all
        @answer_count = Answer.count
        @grouped_answers = current_user.grouped_answers(1) unless Answer.count == 0
        # @feed = current_user.feed.all
        # @feed_items = current_user.feed.paginate(:page => params[:page])
      end
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

  def refresh_stack
    @title = "Home"

    if Stack.count > 0
      @stack = Stack.random
      @interest = Interest.find(@stack.interest_id)
      @choices = @stack.choices
      @answer = @stack.answers.new
        # This version of @grouped_answers gives the count by choice_id, instead of choice_text 
        # @grouped_answers = current_user.grouped_answers(@stack.id) unless @stack.answers.count == 0
        # This UGLY code gives @grouped_answers count by choice_text
        # TODO: Clean this up...maybe store choice_text directly in the Answer model?
        if signed_in?
          @my_answers = Answer.find_all_by_user_id(current_user)
          @my_stack_ids = Array.new
          @my_answers.map { |a| @my_stack_ids << a.stack_id }
          @my_stacks = Stack.find(:all, :conditions=> { :id => @my_stack_ids })
          if !@my_answers.empty?
            @my_last_choice = Choice.find(@my_answers.last.choice_id)
          end
        end
    else
      if signed_in?
          @answer = Answer.new
          # @answers = current_user.my_answers.all
          @answer_count = Answer.count
          @grouped_answers = current_user.grouped_answers(1) unless Answer.count == 0
          # @feed = current_user.feed.all
          # @feed_items = current_user.feed.paginate(:page => params[:page])
      end
    end
    render 'pages/home'
  end

end
