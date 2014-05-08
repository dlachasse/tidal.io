class RemoveIsReadAddLastChecked < ActiveRecord::Migration
  def change
  	add_column :feeds, :last_checked, :datetime
  	remove_column :articles, :is_read
  end
end
