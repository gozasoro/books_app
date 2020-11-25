# frozen_string_literal: true

require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  def setup
    login_as_alice
  end

  test "ユーザーをフォローする" do
    visit users_url
    click_on "Bob"

    click_on "フォローする"
    assert_text "ユーザーをフォローしました。"
    assert_link "フォロー中"
  end

  test "フォロー一覧を表示する" do
    alice_follows_bob

    visit users_url
    click_on "Alice"

    click_on "フォロー"

    assert_text "Bob"
  end

  test "フォロワーを表示する" do
    alice_follows_bob

    visit users_url
    click_on "Bob"

    click_on "フォロワー"

    assert_text "Alice"
  end

  test "フォローを解除する" do
    alice_follows_bob

    visit users_url
    click_on "Bob"

    click_on "フォロー中"
    assert_text "フォローを解除しました。"
    assert_link "フォローする"
  end

  private
    def alice_follows_bob
      alice = users(:alice)
      bob = users(:bob)
      alice.active_relationships.create!(follower_id: bob.id)
    end
end
