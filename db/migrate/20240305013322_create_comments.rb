class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :post, null: false, foreign_key: { on_delete: :cascade }
      t.references :parent_comment, null: false, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
