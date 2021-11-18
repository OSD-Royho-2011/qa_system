class AddRoleToUser < ActiveRecord::Migration[6.1]
  def up
    add_reference :users, :role, null: true, foreign_key: true
  end

  def down
    remove_reference :users, :role, null: true, foreign_key: true
  end
end
