class Role < ApplicationRecord
  has_many :users
  has_many :permissions_roles, :dependent => :delete_all
  has_many :permissions, through: :permissions_roles, :dependent => :delete_all
  default_scope -> { order(created_at: :desc) }
  scope :where_not_admin, -> { where('name != ?', "Super Admin") }
  validates :name, presence: true, uniqueness: true

  def set_permissions(permissions)
    permissions.each do |id|
      if (id != '')
        permission = Permission.find_by(id: id)
        self.permissions << permission
      end
    end
  end
end
