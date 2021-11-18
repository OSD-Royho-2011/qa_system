class RemoveRoleFromPermission < ActiveRecord::Migration[6.1]
  def change
    remove_reference :permissions, :role, null: true, foreign_key: true
  end
end
