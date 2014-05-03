class FixUserColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :password, :crypted_password
  	add_column		:users, :salt, :string
  end
end
