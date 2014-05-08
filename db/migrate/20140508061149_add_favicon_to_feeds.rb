class AddFaviconToFeeds < ActiveRecord::Migration
  def change
  	add_column :feeds, :favicon, :text
  end
end
