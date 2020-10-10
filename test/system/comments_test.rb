# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  def setup
    visit new_user_session_url
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "creating a Comment on book" do
    visit books_url
    click_on "表示", match: :first

    fill_in "コメント", with: "New Comment"
    click_on "登録する"

    assert_text "コメントを作成しました。"
    assert_text "New Comment"
    assert page.all("p.uk-text")[1].find("span").has_text?("Alice")
  end

  test "showing a Comment on book" do
    visit books_url
    click_on "表示", match: :first

    assert_text "book comment by Alice"
  end

  test "updating a Comment on book" do
    visit books_url
    click_on "表示", match: :first

    click_on "編集", match: :first

    fill_in "コメント", with: "comment updated"
    click_on "更新する"

    assert_text "コメントを更新しました。"
    assert_text "comment updated"
  end

  test "destroying a Comment on book" do
    visit books_url
    click_on "表示", match: :first

    click_on "削除", match: :first

    assert_text "コメントを削除しました。"
    assert_no_text "book comment by Alice"
  end

  test "creating a Comment on report" do
    visit reports_url
    click_on "表示", match: :first

    fill_in "コメント", with: "New Comment"
    click_on "登録する"

    assert_text "コメントを作成しました。"
    assert_text "New Comment"
    assert page.all("p.uk-text")[1].find("span").has_text?("Alice")
  end

  test "showing a Comment on report" do
    visit reports_url
    click_on "表示", match: :first

    assert_text "report comment by Alice"
  end

  test "updating a Comment on report" do
    visit reports_url
    click_on "表示", match: :first

    click_on "編集", match: :first

    fill_in "コメント", with: "comment updated"
    click_on "更新する"

    assert_text "コメントを更新しました。"
    assert_text "comment updated"
  end

  test "destroying a Comment on report" do
    visit reports_url
    click_on "表示", match: :first

    click_on "削除", match: :first

    assert_text "コメントを削除しました。"
    assert_no_text "report comment by Alice"
  end
end
