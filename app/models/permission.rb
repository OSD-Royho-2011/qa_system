class Permission < ApplicationRecord
  has_many :permissions_roles, :dependent => :delete_all
  has_many :roles, through: :permissions_roles, :dependent => :delete_all
  scope :where_not_admin_permission, -> { where('subject_class != ?', "all") }
  validates :subject_class, presence: true
  validates :action, presence: true
end
