class Action < ApplicationRecord
  belongs_to :user
  belongs_to :question
  enum action: {likable: 0, dislikable: 1}
  scope :where_likable, -> { where(action: :likable) }
  scope :where_dislikable, -> { where(action: :dislikable) }

  def change_to_liked
    update_attribute(:action, :likable)
  end

  def change_to_disliked
    update_attribute(:action, :dislikable)
  end

end
