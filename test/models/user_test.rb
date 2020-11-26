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

  test "User.from_omniauthでユーザーが登録されている場合、そのユーザーを返す" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "1234",
      info: { nickname: "mockuser", email: "mockuser@example.com" }
    })
    user = User.create!(name: "mockuser", email: "mockuser@example.com", password: "password", provider: "github", uid: "1234")
    assert_equal user, User.from_omniauth(auth_hash)
  end

  test "User.from_omniauthでユーザーが登録されていない場合、Userを新規作成し情報を入れる" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "1234",
      info: { nickname: "mockuser", email: "mockuser@example.com" }
    })
    assert_equal 3, User.count
    user = User.from_omniauth(auth_hash)
    assert_equal 4, User.count
    assert_equal "github", user.provider
    assert_equal "1234", user.uid
    assert_equal "mockuser", user.name
    assert_equal "mockuser@example.com", user.email
    assert user.password
  end

  test "User.from_omniauthでemailが取得できなかった場合にUser.dummy_emailでemailを入れる" do
    auth_hash = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "1234",
      info: { nickname: "mockuser" }
    })
    user = User.from_omniauth(auth_hash)
    assert_equal "1234-github@example.com", user.email
  end

  test "#update_with_password" do
    # aliceはomniauthでログインしていないのでpassword必須
    assert_not @alice.update_with_password(email: "alice_updated@example.com")
    assert @alice.update_with_password(email: "alice_updated@example.com", current_password: "password")
    # aliceでpasswordを間違えた場合
    assert_not @alice.update_with_password(email: "alice_updated@example.com", current_password: "wrong_password")
    # carolはomniauthでログインしているのでパスワード不要
    assert @carol.update_with_password(email: "bob_updated@example.com")
  end
end
