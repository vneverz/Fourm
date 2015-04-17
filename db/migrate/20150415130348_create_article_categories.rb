class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.integer :article_id
      t.integer :category_id
      t.timestamps null: false
    end
    add_index :article_categories, :article_id
    add_index :article_categories, :category_id
  end
end
