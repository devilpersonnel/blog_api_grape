class Comment < ActiveRecord::Base
  belongs_to :post
  validates :commenter, presence: true
  validates :text, presence: true
end
