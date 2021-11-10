class SubCategory < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, length: { maximum: 140 }
end
