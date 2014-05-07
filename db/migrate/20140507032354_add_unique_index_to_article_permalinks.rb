class AddUniqueIndexToArticlePermalinks < ActiveRecord::Migration
  def change
  	add_index :articles, :permalink, unique: true
  end
end
