require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "StkUp - Simple, Purposeful Comparisons"
  end

  describe "GET 'home'" do

    describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end
    
      it "should have the right title" do
        get 'home'
        response.should have_selector("title",
                                      :content => @base_title + " | Home")
      end

      it "should display the logo" do
        get 'home'
        File.exists? "/images/stkup_logo.png"
        # response.should have_tag('img[src=?]',
        #                          /\/images\/stkup_logo.png\S*/)
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @interest = Factory(:interest)
        @user.interested_in!(@interest)
      end

      it "should have the right interested_in counts" do
        get :home
        response.should have_selector("a", :href => interests_user_path(@user),
                                           :content => "1 interest")
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_title + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                                    :content => @base_title + " | Help")
    end
  end

end
