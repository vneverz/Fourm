class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.boolean :is_public
      t.datetime :post_time

      t.timestamps null: false
    end
  end
end
