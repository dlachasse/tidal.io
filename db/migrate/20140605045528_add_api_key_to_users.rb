class AddApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_key, :text
    add_index :users, :api_key, unique: true
  end
end
