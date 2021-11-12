class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question
  belongs_to :parent,  class_name: "Comment", optional: true
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: :true
end
