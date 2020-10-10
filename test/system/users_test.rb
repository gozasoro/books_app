# frozen_string_literal: true

require "application_system_test_case"
require "omniauth"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "ユーザー一覧"

    assert_text "Alice"
    assert_text "Bob"
    assert_text "Carol"
  end

  test "creating a User" do
    visit new_user_registration_url
    fill_in "ユーザーネーム", with: "Dave"
    fill_in "Eメール", with: "dave@example.com"
    fill_in "パスワード", with: "password"
    fill_in "パスワード（確認用）", with: "password"

    click_button "アカウント登録"

    assert_text "アカウント登録が完了しました。"
    click_on "マイページ"

    assert_text "Dave"
    assert_text "dave@example.com"
  end

  test "showing a User" do
    login_with_alice

    visit users_url

    click_on "Bob"

    assert_text "Bob"
    assert_no_text "bob@example.com"
  end

  test "updating a User" do
    login_with_alice

    click_on "マイページ"

    click_on "編集"

    fill_in "ユーザーネーム", with: "Alice:)"
    fill_in "自己紹介", with: "Hi!"
    fill_in "郵便番号", with: "123-4567"
    fill_in "住所", with: "New York"
    fill_in "Eメール", with: "alice_updated@example.com"
    fill_in "パスワード", with: "password_updated"
    fill_in "パスワード（確認用）", with: "password_updated"
    fill_in "現在のパスワード", with: "password"
    click_on "更新"

    assert_text "アカウント情報を変更しました。"
    click_on "マイページ"

    assert_text "Alice:)"
    assert_text "Hi!"
    assert_text "alice_updated@example.com"
    assert_text "123-4567"
    assert_text "New York"
  end

  test "destroying a User" do
    login_with_alice

    click_on "マイページ"

    click_on "編集"

    fill_in "現在のパスワード", with: "password"
    page.accept_confirm do
      click_on "アカウント削除"
    end

    assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
  end

  test "GitHubアカウントでログイン" do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "1234",
      info: {
        nickname: "mockuser",
        email: "mockuser@example.com"
      }
    })

    visit new_user_session_url
    click_on "GitHubでログイン"

    assert_text "GitHub アカウントによる認証に成功しました。"
  end

  test "ログアウト" do
    login_with_alice
    click_on "ログアウト"

    assert_text "ログアウトしました。"
    assert_selector "h1", text: "本一覧"
  end

  private
    def login_with_alice
      visit new_user_session_url
      fill_in "Eメール", with: "alice@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end
end
