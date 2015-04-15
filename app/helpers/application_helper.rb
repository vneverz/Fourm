module ApplicationHelper
  def user_gavatar(user)
    image_tag user.gavatar_url, :class => "media-object", :width => "64", :alt => "user gavatar"
  end
end
