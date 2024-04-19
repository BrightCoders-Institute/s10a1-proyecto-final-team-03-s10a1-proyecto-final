class AddNameToSeries < ActiveRecord::Migration[7.1]
  def change
    add_column :series, :name, :string
  end
end
