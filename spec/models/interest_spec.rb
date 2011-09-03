require 'spec_helper'

describe Interest do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
    @user = User.create!(@attr)
    @interest = Factory(:interest)
    @user_interest = @user.interests.build(:interest_id => @interest.id)
  end

  describe "user interest methods" do

    before(:each) do
      @user_interest.save
    end

    it "should have a reverse_interests method" do
      @interest.should respond_to(:reverse_interests)
    end

    it "should have a interested_users method" do
      @interest.should respond_to(:interested_users)
    end

    it "should include the interested_in user in the interested_users array" do
      @user.interested_in!(@interest)
      @interest.interested_users.should include(@user)
    end
  end
  
  describe "stack associations" do

    before(:each) do
        @attr = {
          :question => "How much do you pay your babysitter?",
          :question_subtext => "The amount you typically pay your babysitter per hour",
          :choice_picker_type => "select",
          :chart_type => "pie",
          :created_by => "1"
        }
        @stack = @interest.stacks.create(@attr)
    end

    it "should have a stacks attribute" do
      @interest.should respond_to(:stacks)
    end

    it "should have the right stack" do
      @interest.stacks.should == [@stack]
    end
    
    it "should destroy associated stacks" do
      @interest.destroy
      Stack.find_by_id(@stack.id).should be_nil
    end
  end

end
