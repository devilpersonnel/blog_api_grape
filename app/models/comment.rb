class Comment < ActiveRecord::Base
  validates :commenter, presence: true
  validates :text, presence: true
end
