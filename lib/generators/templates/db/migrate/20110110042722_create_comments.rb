class CreateComments < ActiveRecord::Migration
  def up
    create_table :spree_comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.string  :name
      t.string  :email
      t.string  :url
      t.text    :message
      t.boolean :approved, default: false
      t.datetime :approved_on

      t.timestamps
    end
  end

  def down
    drop_table :spree_comments
  end
end
