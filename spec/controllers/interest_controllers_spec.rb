require 'spec_helper'

describe InterestsController do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @interest = Factory(:interest)
    end

    it "should be successful" do
      get :show, :id => @interest
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @interest
      assigns(:interest).should == @interest
    end

    it "should have the right title" do
      get :show, :id => @interest
      response.should have_selector("title", :content => @interest.interest_desc)
    end

    it "should show the stacks in the category of interest" do
      stk = Factory(:stack, :interest => @interest)
      get :show, :id => @interest
      response.should have_selector("span.question",   :content => stk.question)
    end
  end
end
