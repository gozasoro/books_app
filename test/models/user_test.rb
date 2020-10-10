# frozen_string_literal: true

require "test_helper"
require "omniauth"

class UserTest < ActiveSupport::TestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
    @carol = users(:carol)
  end

  test "#followed_by?" do
    assert_not @bob.followed_by?(@alice)
    @alice.active_relationships.create!(follower_id: @bob.id)
    assert @bob.followed_by?(@alice)
  end

  test "#self.from_omniauthでユーザーが登録されている場合、そのユーザーを返す" do
    set_auth
    user = User.create!(name: "mockuser", email: "mockuser@example.com", password: "password", provider: "github", uid: "1234")
    assert_equal user, User.from_omniauth(@auth)
  end

  test "#self.from_omniauthでユーザーが登録されていない場合、Userを新規作成し情報を入れる" do
    set_auth
    user = User.from_omniauth(@auth)
    assert_equal "github", user.provider
    assert_equal "1234", user.uid
    assert_equal "mockuser", user.name
    assert_equal "mockuser@example.com", user.email
    assert user.password
  end

  test "#self.dummy_email" do
    set_auth
    assert_equal "1234-github@example.com", User.dummy_email(@auth)
  end

  test "#self.create_unique_string" do
    string1 = User.create_unique_string
    string2 = User.create_unique_string

    assert_instance_of String, string1
    assert_instance_of String, string2
    assert_not_equal string1, string2
  end

  test "#update_with_password" do
    assert_not @alice.update_with_password({ email: "alice_updated@example.com" })
    assert @alice.update_with_password({ email: "alice_updated@example.com", current_password: "password" })
    assert @carol.update_with_password({ email: "bob_updated@example.com" })
  end

  private
    def set_auth
      @auth = OmniAuth::AuthHash.new({
        provider: "github",
        uid: "1234",
        info: { nickname: "mockuser", email: "mockuser@example.com" }
      })
    end
end
