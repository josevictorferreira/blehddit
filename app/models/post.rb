## Class for users posts, and links to share.
class Post < ApplicationRecord
  after_initialize :set_votes_to_0
  before_save :gen_link_thumbnailer

  belongs_to :user, class_name: 'User', required: true

  validates :title, presence: true
  validates :link, presence: true
  validates :user, presence: true

  def gen_link_thumbnailer
    img = LinkThumbnailer.generate(link).images.first.src
    self.image = img unless link.blank? || img.nil
  end

  def set_votes_to_0
    self.upvotes = 0
    self.downvotes = 0
  end

  def votes
    upvotes - downvotes
  end

  def upvote!
    self.upvotes += 1
  end

  def downvote!
    self.downvotes += 1
  end
end
