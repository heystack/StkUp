class Choice < ActiveRecord::Base
  attr_accessible :stack_id
  attr_accessible :choice_text, :choice_default, :choice_sort_order

  belongs_to :stack
  has_many   :answers
  
  validates :choice_text, :presence => true
end
