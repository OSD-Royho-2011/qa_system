class RemovePreviewedColumnFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :previewed, :boolean, :default => false
  end
end
