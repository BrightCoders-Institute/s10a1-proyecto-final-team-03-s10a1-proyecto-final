class CreateFollowers < ActiveRecord::Migration[7.1]
  def change
    create_table :followers do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :follower_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
