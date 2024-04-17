class CreateSeries < ActiveRecord::Migration[7.1]
  def change
    create_table :series do |t|
      t.integer :repetitions
      t.float :weight
      t.references :routine, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
