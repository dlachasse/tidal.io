class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :permalink
      t.text :body
      t.datetime :published
      t.boolean :is_read
      t.integer :feed_id

      t.timestamps
    end

    add_index :articles, :feed_id
  end
end
