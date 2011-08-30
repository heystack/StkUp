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
end
