class Article < ActiveRecord::Base
  validates_presence_of :title, :description, :user_id
  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :article_categories
  has_many :categories, :through => :article_categories
  # 假設要限定最多顯示四位留言者
  def authors(n=4)
    arr = self.comments.map { |c| c.user}
    arr << self.user
    arr.uniq.first(n)
  end

  def self.only_published(user)
    if user
    where( ["status = ? OR ( status = ? AND user_id = ? )", "published", "draft", user.id ] )
    else
    where( :status => "published" )
    end
  end

  def view!
    self.increment!(:views_count)
  end
  # 或是其他用sql的方法
  # def authors
  #   arr = self.comments.limit(3).map { |c| c.user}
  #   arr << self.user
  #   arr.uniq
  # end

  def can_delete_by?(u)
   ( self.user == u ) || (u&&u.is_admin?)
  end

end
