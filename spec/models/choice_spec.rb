require 'spec_helper'

describe Choice do
  before(:each) do
    @choice_attr = { :choice_text => "Less than $10" }
    @stack = Factory(:stack)
  end

  it "should create a new choice given valid attributes" do
    @stack.choices.create!(@choice_attr)
  end
  
  describe "choice associations" do

    before(:each) do
      @choice = @stack.choices.create(@choice_attr)
    end

    it "should have a stack attribute" do
      @choice.should respond_to(:stack)
    end

    it "should have the right associated stack" do
      @choice.stack_id.should == @stack.id
      @choice.stack.should == @stack
    end
  end

  describe "validations" do

    it "should require nonblank choice" do
      @stack.choices.build(:choice_text => "  ").should_not be_valid
    end
  end
end
