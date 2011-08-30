class UserInterest < ActiveRecord::Base
  attr_accessible :interest_id
  
  belongs_to :user
  belongs_to :interest
  
  validates :user_id, :presence => true
  validates :interest_id, :presence => true
end
