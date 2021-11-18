class AddDescriptionToRole < ActiveRecord::Migration[6.1]
  def up
    add_column :roles, :description, :string
  end

  def down
    remove_column :roles, :description, :string
  end
end
