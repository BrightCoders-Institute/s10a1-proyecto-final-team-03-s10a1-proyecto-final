class RemoveRepetitionsAndWeightFromSeries < ActiveRecord::Migration[7.1]
  def change
    remove_column :series, :repetitions, :integer
    remove_column :series, :weight, :float
  end
end
