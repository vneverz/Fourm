class Comment < ActiveRecord::Base
  validates_presence_of :content, :user_id
  belongs_to :user
  belongs_to :article, :counter_cache => true

  def can_delete_by?(u)
     ( self.user == u ) || (u && u.is_admin?)
  end

end
