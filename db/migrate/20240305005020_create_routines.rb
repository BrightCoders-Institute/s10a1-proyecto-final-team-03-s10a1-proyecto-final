class CreateRoutines < ActiveRecord::Migration[7.1]
  def change
    create_table :routines do |t|
      t.string :exercise
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
