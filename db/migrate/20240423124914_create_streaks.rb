class CreateStreaks < ActiveRecord::Migration[7.1]
  def change
    create_table :streaks do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer :current_streak
      t.integer :longest_streak
      t.date :last_login_date

      t.timestamps
    end
  end
end
