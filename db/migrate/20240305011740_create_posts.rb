class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer :comment_number

      t.timestamps
    end
  end
end
