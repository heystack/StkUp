require 'spec_helper'

describe Stack do
  before(:each) do
    @attr = {
      :question => "How much do you pay your babysitter?",
      :question_subtext => "The amount you typically pay your babysitter per hour",
      :choice_picker_type => "select",
      :chart_type => "pie",
      :created_by => "1"
    }
    @interest = Factory(:interest)
  end

  it "should create a new stack given valid attributes" do
    @interest.stacks.create!(@attr)
  end
  
  describe "stack associations" do

    before(:each) do
      @stack = @interest.stacks.create(@attr)
    end

    it "should have a interest attribute" do
      @stack.should respond_to(:interest)
    end

    it "should have the right associated interest" do
      @stack.interest_id.should == @interest.id
      @stack.interest.should == @interest
    end
  end

  describe "validations" do

    it "should require a interest id" do
      Stack.new(@attr).should_not be_valid
    end

    it "should require nonblank question, choice_picker_type, chart_type" do
      @interest.stacks.build(:question => "  ").should_not be_valid
      @interest.stacks.build(:choice_picker_type => "  ").should_not be_valid
      @interest.stacks.build(:chart_type => "  ").should_not be_valid
    end

  end
  
end
