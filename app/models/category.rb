class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :category_questions, :dependent => :delete_all
  has_many :questions, through: :category_questions, :dependent => :delete_all
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, uniqueness: true
end
