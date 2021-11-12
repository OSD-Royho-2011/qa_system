class ChangeContentDataTypeFromComment < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :content, :text
  end
end
