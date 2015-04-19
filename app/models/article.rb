class Article < ActiveRecord::Base
  validates_presence_of :title, :description, :user_id
  belongs_to :user
  has_many :comments

  has_many :article_categories
  has_many :categories, :through => :article_categories
  def authors
    arr = self.comments.map { |c| c.user}
    arr << self.user
    arr.uniq
  end
end
