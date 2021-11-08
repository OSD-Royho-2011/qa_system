class AddRememberDigestToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :remember_digest, :string
  end

  def down
    remove_column :users, :remember_digest, :string
  end
end
