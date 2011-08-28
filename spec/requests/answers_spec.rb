require 'spec_helper'

describe "Answers" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
  end
  
  describe "creation" do
    
    describe "failure" do
    
      it "should not make a new answer" do
        lambda do
          visit root_path
          fill_in :answer_stack_id, :with => ""
          fill_in :answer_choice_id, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Answer, :count)
      end
    end

    describe "success" do
  
      it "should make a new answer" do
        stack_id = "1"
        choice_id = "15"
        lambda do
          visit root_path
          fill_in :answer_stack_id, :with => stack_id
          fill_in :answer_choice_id, :with => choice_id
          click_button
          response.should have_selector("div#chart_div")
          # response.should have_selector("span.stack",  :content => stack_id)
          # response.should have_selector("span.choice", :content => choice_id)
        end.should change(Answer, :count).by(1)
      end
    end
  end
end
