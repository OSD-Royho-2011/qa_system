class AddPreviewedColumnToQuestions < ActiveRecord::Migration[6.1]
  def up
    add_column :questions, :previewed, :boolean, :default => false
  end

  def down
    remove_column :questions, :previewed, :boolean, :default => false
  end
end
