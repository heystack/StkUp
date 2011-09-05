class Stack < ActiveRecord::Base
  attr_accessible :interest_id
  attr_accessible :question, :question_subtext
  attr_accessible :choice_picker_type, :chart_type, :created_by
  
  belongs_to :interest
  has_many   :choices
  has_many   :answers
  
  validates :interest_id,        :presence => true
  validates :question,           :presence => true
  validates :choice_picker_type, :presence => true
  validates :created_by,         :presence => true
  
end
