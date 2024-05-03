class CreateStories < ActiveRecord::Migration[7.1]
  def change
    create_table :stories do |t|
      t.string :body
      t.date :day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
