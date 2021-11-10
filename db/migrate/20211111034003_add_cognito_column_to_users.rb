class AddCognitoColumnToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :cognito, :boolean, :default => false
  end

  def down
    remove_column :users, :cognito, :boolean, :default => false
  end
end
