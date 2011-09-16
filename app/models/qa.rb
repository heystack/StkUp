class Qa < ActiveRecord::Base
  attr_accessible :qa_link, :qa_desc, :qa_target
  
  belongs_to :stack
end
