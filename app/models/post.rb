class Post < ApplicationRecord

  before_save :get_link_thumbnailer, :set_votes_to_0

  def get_link_thumbnailer
    unless link.blank?
      img = LinkThumbnailer.generate(self.link).images.first.src
      self.image = img unless img.nil?
    end
  end

  def set_votes_to_0
    self.upvotes, self.downvotes = 0, 0
  end

  def votes
    return self.upvotes - self.downvotes
  end
end
