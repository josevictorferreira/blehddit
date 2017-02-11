require 'test_helper'

class PostTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in(User.first)
    @post = posts(:one)
    @post.user = User.first
  end

  test 'should initialize upvotes to 0' do
    assert_equal @post.upvotes, 0
    assert_equal @post.downvotes, 0
  end

  test 'should calculate votes' do
    @post.upvotes = 8
    @post.downvotes = 11
    assert_equal @post.votes, -3
    @post.upvotes = 54
    @post.downvotes = 16
    assert_equal @post.votes, 38
  end

  test 'should upvote! with +1 to upvote' do
    @post.upvote!
    assert_equal @post.upvotes, 1
  end

  test 'should downvote! with +1 to downvote' do
    @post.downvote!
    assert_equal @post.downvotes, 1
  end

  test 'should generate image thumbnail' do
    image = 'https://i.kinja-img.com/gawker-media/image/upload/s--1V_EkVGj--/c_fill,fl_progressive,g_center,h_450,q_80,w_800/il1hcxddgfe0unecooxv.jpg'
    @post.save!
    assert @post.image == image
    @post.destroy
  end

  test 'should validate presence of link and title' do
    assert_not Post.create(link: @post.link).valid?
    assert_not Post.create(title: @post.title).valid?
    assert Post.create(user: User.first,
                       link: @post.link,
                       title: @post.title).valid?
  end
end
