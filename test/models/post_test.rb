require 'test_helper'

class PostTest < ActiveSupport::TestCase

  setup do
    @post = posts(:one)
  end

  test "should initialize upvotes to 0" do
    assert_equal @post.upvotes, 0
    assert_equal @post.downvotes, 0
  end

  test "should calculate votes" do
    @post.upvotes = 8
    @post.downvotes = 11
    assert_equal @post.votes, -3
    @post.upvotes = 54
    @post.downvotes = 16
    assert_equal @post.votes, 38
  end

  test "should upvote! with +1 to upvote" do
    @post.upvote!
    assert_equal @post.upvotes, 1
  end

  test "should downvote! with +1 to downvote" do
    @post.downvote!
    assert_equal @post.downvotes, 1
  end

  test "should generate image thumbnail" do
    image = 'http://og.infg.com.br/in/20838706-b1e-999/FT1086A/64602505_French-Foreign-Minister-Jean-Marc-Ayrault-R-holds-a-joint-press-conference-with-his-German.jpg'
    @post.save
    assert @post.image.include? image
    @post.destroy
  end

  test "should validate presence of link and title" do
    assert_not Post.create(link: @post.link).valid?
    assert_not Post.create(title: @post.title).valid?
    assert Post.create(link: @post.link, title: @post.title).valid?
  end

end
