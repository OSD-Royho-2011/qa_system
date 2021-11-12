class Question < ApplicationRecord
  belongs_to :user, optional: true
  has_many :category_questions, :dependent => :delete_all
  has_many :categories, through: :category_questions, :dependent => :delete_all
  has_one_attached :image
  has_many :actions
  enum status: {waiting: 0, approved: 1, closed: 2}
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
  validates :status, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                    size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
