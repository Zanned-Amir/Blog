require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  def blog_post
    BlogPost.new(published_at: nil)
  end

  test "draft? returns true for draft blog post" do
    assert blog_posts(:draft).draft?
  end

  test "draft? returns false for published blog post" do
    refute BlogPost.new(published_at: Time.now).draft?
  end

  test "published? returns true for scheduled blog post" do
    refute BlogPost.new(published_at: Time.now + 1.day).published?
  end

  test "published? returns true for published blog post" do
    assert BlogPost.new(published_at: 1.year.ago).published?
  end

  test "published? returns false for draft blog post" do
    refute blog_post.published?
  end

  test "published? returns false for scheduled blog post" do
    refute BlogPost.new(published_at: Time.now + 1.day).published?
  end



end
