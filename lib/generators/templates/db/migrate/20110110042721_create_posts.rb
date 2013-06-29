class CreatePosts < ActiveRecord::Migration
  def up
    create_table :spree_posts do |t|
      t.string :title
      t.string :permalink
      t.text :summary
      t.text :body
      t.text :tags
      t.boolean :publish
      t.datetime :published_on
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end

  def down
    drop_table :spree_posts
  end
end
