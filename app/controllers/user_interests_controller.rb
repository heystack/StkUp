class UserInterestsController < ApplicationController
  before_filter :authenticate
    
  def create
    @interest = Interest.find(params[:user_interest][:interest_id])
    current_user.interested_in!(@interest)
    respond_to do |format|
      format.html { redirect_to @interest }
      format.js
    end
  end

  def destroy
    @interest = UserInterest.find(params[:id]).interest
    current_user.not_interested_in!(@interest)
    respond_to do |format|
      format.html { redirect_to @interest }
      format.js
    end
  end
end
