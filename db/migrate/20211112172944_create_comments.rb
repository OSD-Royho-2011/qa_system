class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: true, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :parent_id
      t.string :private_token
      t.string :content

      t.timestamps
    end
  end
end
