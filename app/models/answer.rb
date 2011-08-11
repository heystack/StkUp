class Answer < ActiveRecord::Base
  attr_accessible :choice_id, :stack_id # ToDo: Remove stack_id
  
  belongs_to :user

  validates :choice_id, :presence => true
  validates :stack_id,  :presence => true
  validates :user_id,   :presence => true

  default_scope :order => 'answers.created_at DESC'
end
