class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :category_questions, :dependent => :delete_all
  has_many :questions, through: :category_questions, :dependent => :delete_all
  validates :name, presence: true
end
