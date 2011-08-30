class Interest < ActiveRecord::Base
  attr_accessible :interest_id

  has_many :reverse_interests, :foreign_key => "interest_id",
                               :class_name => "UserInterest",
                               :dependent => :destroy  
  has_many :interested_users,  :through => :reverse_interests,
                               :source => :user

end
