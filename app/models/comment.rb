class Comment < ActiveRecord::Base
  validates_presence_of :content, :user_id
  belongs_to :user
  belongs_to :article
end
