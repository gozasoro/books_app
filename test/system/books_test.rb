# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  def setup
    visit new_user_session_url
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "本一覧"

    assert_text "Book Title 1"
    assert_text "Book Memo 1"
    assert_text "Book Author 1"
  end

  test "creating a Book" do
    visit books_url
    click_on "新しい本を登録"

    fill_in "タイトル", with: "New Book Title"
    fill_in "メモ", with: "New Book Memo"
    fill_in "著者", with: "New Book Author"
    click_on "登録する"

    assert_text "新しい本を登録しました。"

    assert_text "New Book Title"
    assert_text "New Book Memo"
    assert_text "New Book Author"
  end

  test "showing a Book" do
    visit books_url
    click_on "表示", match: :first

    assert_text "Book Title 1"
    assert_text "Book Memo 1"
    assert_text "Book Author 1"
  end

  test "updating a Book" do
    visit books_url
    click_on "編集", match: :first

    fill_in "タイトル", with: "Edit Title"
    fill_in "メモ", with: "Edit Memo"
    fill_in "著者", with: "Edit Author"
    click_on "更新する"

    assert_text "本を更新しました。"

    assert_text "Edit Title"
    assert_text "Edit Memo"
    assert_text "Edit Author"
  end

  test "destroying a Book" do
    visit books_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "本を削除しました。"
    assert_no_text "Book Title 1"
    assert_no_text "Book Memo 1"
    assert_no_text "Book Author 1"
  end
end
