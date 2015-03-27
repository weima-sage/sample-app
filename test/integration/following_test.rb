require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    log_in_as @user
  end

  test 'following page' do
    get following_user_path @user
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end 

  test 'follower page' do
    get followers_user_path @user
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end 

  test 'should follow a user the standard way' do
    follow_test do
      post relationships_path, followed_id: @other.id
    end
  end

  test 'should follow a user with Ajax' do
    follow_test do
      xhr :post, relationships_path, followed_id: @other.id
    end
  end

  test 'should unfollow a user the standard way' do
    unfollow_test do |relationship|
      delete relationship_path(relationship)
    end
  end

  test 'should unfollow a user with Ajax' do
    unfollow_test do |relationship|
      xhr :delete, relationship_path(relationship)
    end
  end


  private 
    def follow_test(&block)
      assert_difference('@user.following.count', 1, &block)
    end

    def unfollow_test(&block)
      @user.follow @other
      relationship = @user.active_relationships.find_by(followed_id: @other.id)
      new_block = lambda do
        block.call(relationship)
      end
      assert_difference('@user.following.count', -1, &new_block)
    end



end
