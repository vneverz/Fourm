class Article < ActiveRecord::Base
  validates_presence_of :title, :description

  belongs_to :user
  has_many :comments
end
