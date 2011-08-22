class Answer < ActiveRecord::Base
  attr_accessible :choice_id, :stack_id # ToDo: Remove stack_id
  
  belongs_to :user

  validates :choice_id, :presence => true
  validates :stack_id,  :presence => true
  validates :user_id,   :presence => true

  # Following line caused error on heroku: ERROR:  column "answers.created_at" must appear in the GROUP BY clause...
  # default_scope :order => 'answers.created_at DESC'

  # ToDo: How do I get total_for into Answer instead of User class
  def total_for(choice_id)
    where("choice_id = ?", choice_id).count(:choice_id)
  end
  
end
