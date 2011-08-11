require 'spec_helper'

describe Answer do

  before(:each) do
    @user = Factory(:user)
    @attr = { :choice_id => "15", :stack_id => "1" }
  end

  it "should create a new instance given valid attributes" do
    @user.answers.create!(@attr)
  end

  describe "user associations" do
    
    before(:each) do
      @answer = @user.answers.create(@attr)
    end

    it "should have a user attribute" do
      @answer.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @answer.user_id.should == @user.id
      @answer.user.should == @user
    end
  end


  describe "validations" do

    it "should require a user id" do
      Answer.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.answers.build(:choice_id => "  ").should_not be_valid
      @user.answers.build(:stack_id => "  ").should_not be_valid
    end
  end
end
