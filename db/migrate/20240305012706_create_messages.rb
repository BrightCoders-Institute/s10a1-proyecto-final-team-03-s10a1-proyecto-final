class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :message_parent, null: false, foreign_key: { to_table: :messages }

      t.timestamps
    end
  end
end
