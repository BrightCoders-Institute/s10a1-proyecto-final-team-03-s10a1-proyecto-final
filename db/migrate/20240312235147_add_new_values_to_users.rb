class AddNewValuesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :avatar_url, :string
    add_column :users, :provider, :string
    add_column :users, :following_count, :integer, default: 0
    add_column :users, :followers_count, :integer, default: 0
  end
end
