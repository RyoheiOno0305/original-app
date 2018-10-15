class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  def self.ranking
    self.group(:follow_id).order('count_follow_id DESC').limit(10).count(:follow_id)
  end
end
