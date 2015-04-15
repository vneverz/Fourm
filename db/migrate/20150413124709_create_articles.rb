class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.boolean :is_public
      t.integer :comments_count, :default => 0
      t.integer :user_id

      t.timestamps null: false
    end
      add_index :articles, :user_id
  end
end
