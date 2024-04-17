class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.integer :repetitions
      t.float :weight
      t.references :series, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
