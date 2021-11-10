class AddAdminColumnToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :admin, :boolean
  end

  def down
    remove_column :users, :admin, :boolean
  end
end
