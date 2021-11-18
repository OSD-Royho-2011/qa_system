class AddRoleToPermission < ActiveRecord::Migration[6.1]
  def up
    add_reference :permissions, :role, null: true, foreign_key: true
  end

  def down
    remove_reference :permissions, :role, null: true, foreign_key: true
  end
end
