class Post < ApplicationRecord

  before_save :get_link_thumbnailer

  def get_link_thumbnailer
    unless link.blank?
      img = LinkThumbnailer.generate(self.link).images.first.src
      self.image = img unless img.nil?
    end
  end
end
