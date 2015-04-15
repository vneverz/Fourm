class AddCommentsCountToArticle < ActiveRecord::Migration
  def change
    Article.pluck(:id).each do |i|
      Article.reset_counters(i, :comments) # 全部重算一次
    end
  end
end
