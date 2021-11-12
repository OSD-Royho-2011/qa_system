class ChangeDataConventionForComment < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :parent_id, :integer, null: true
    change_column :comments, :private_token, :string, null: true
  end
end
