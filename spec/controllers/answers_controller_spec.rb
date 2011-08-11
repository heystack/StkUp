require 'spec_helper'

describe AnswersController do
  render_views
  
  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :stack_id => "", :choice_id => "" }
      end

      it "should not create an answer" do
        lambda do
          post :create, :answer => @attr
        end.should_not change(Answer, :count)
      end

      it "should render the home page" do
        post :create, :answer => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :stack_id => "1", :choice_id => "15" }
      end

      it "should create a micropost" do
        lambda do
          post :create, :answer => @attr
        end.should change(Answer, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :answer => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :answer => @attr
        flash[:success].should =~ /answer created/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @answer = Factory(:answer, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @answer
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @answer = Factory(:answer, :user => @user)
      end

      it "should destroy the answer" do
        lambda do 
          delete :destroy, :id => @answer
        end.should change(Answer, :count).by(-1)
      end
    end
  end
end

