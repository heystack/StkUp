class Stack < ActiveRecord::Base
  attr_accessible :interest_id
  attr_accessible :question, :question_subtext
  attr_accessible :choice_picker_type, :chart_type, :created_by
  
  belongs_to :interest
  has_many   :choices
  has_many   :answers
  has_many   :qas
  
  validates :interest_id,        :presence => true
  validates :question,           :presence => true
  validates :created_by,         :presence => true

  def created_by?(user)
    user == User.find_by_id(self.created_by)
  end

  def self.random
    ids = connection.select_all("SELECT id FROM stacks")
    find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end

end
