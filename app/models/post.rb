class Post < ApplicationRecord

  after_initialize :set_votes_to_0
  before_save :get_link_thumbnailer

  belongs_to :user, class_name: 'User', required: true

  validates :title, presence: true
  validates :link, presence: true
  validates :user, presence: true

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

  def upvote!
    self.upvotes += 1
  end

  def downvote!
    self.downvotes += 1
  end
end
