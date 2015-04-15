class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :comments
  def gavatar_url
    md5 = Digest::MD5.hexdigest(self.email.downcase)
    "https://www.gravatar.com/avatar/#{md5}"
  end
end
