class CreateCategoryQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :category_questions, :id => false do |t|
      t.references :category, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end