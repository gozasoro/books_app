# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  def setup
    login_as_alice
  end

  test "creating a Comment on book" do
    visit book_path(books(:wagashi))

    fill_in "コメント", with: "とてもよかったです。"
    click_on "登録する"

    assert_text "コメントを作成しました。"
    assert_text "とてもよかったです。"
    assert page.all(".comment")[1].find(".comment-created-by").has_text?("Alice")
  end

  test "showing a Comment on book" do
    visit book_path(books(:wagashi))

    assert_text "わらびもち食べたい！"
  end

  test "updating a Comment on book" do
    visit book_path(books(:wagashi))

    within ".comments" do
      click_on "編集", match: :first
    end

    fill_in "コメント", with: "わらびもち食べたい〜！"
    click_on "更新する"

    assert_text "コメントを更新しました。"
    assert_text "わらびもち食べたい〜！"
  end

  test "destroying a Comment on book" do
    visit book_path(books(:wagashi))

    assert_text "わらびもち食べたい！"

    within ".comments" do
      click_on "削除", match: :first
    end

    assert_text "コメントを削除しました。"
    assert_no_text "わらびもち食べたい！"
  end

  test "creating a Comment on report" do
    visit report_path(reports(:one_day_report))

    fill_in "コメント", with: "あんみつも食べたい！"
    click_on "登録する"

    assert_text "コメントを作成しました。"
    assert_text "あんみつも食べたい！"
    assert page.all(".comment")[1].find(".comment-created-by").has_text?("Alice")
  end

  test "showing a Comment on report" do
    visit report_path(reports(:one_day_report))

    assert_text "トッピングはスプリングル"
  end

  test "updating a Comment on report" do
    visit report_path(reports(:one_day_report))

    within ".comments" do
      click_on "編集", match: :first
    end

    fill_in "コメント", with: "ワッフルコーンにトッピングはスプリングル"
    click_on "更新する"

    assert_text "コメントを更新しました。"
    assert_text "ワッフルコーンにトッピングはスプリングル"
  end

  test "destroying a Comment on report" do
    visit report_path(reports(:one_day_report))

    assert_text "トッピングはスプリングル"

    within ".comments" do
      click_on "削除", match: :first
    end

    assert_text "コメントを削除しました。"
    assert_no_text "トッピングはスプリングル"
  end
end
