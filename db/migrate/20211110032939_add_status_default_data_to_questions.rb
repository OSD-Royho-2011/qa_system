class AddStatusDefaultDataToQuestions < ActiveRecord::Migration[6.1]
  def change
    change_column :questions, :status, :integer, :default => 0
  end
end
