class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :private_token
      t.text :content
      t.integer :status
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
    add_index :questions, [:user_id, :created_at]
  end
end
