# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  def setup
    login_as_alice
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "本一覧"

    assert_text "日本和菓子食べ歩き"
    assert_text "全国各地の和菓子を素敵な風景と一緒に楽しめる本です。"
    assert_text "デイヴ"
  end

  test "creating a Book" do
    visit books_url
    click_on "新しい本を登録"

    fill_in "タイトル", with: "おいしいクレープレシピ"
    fill_in "メモ", with: "色々な創作クレープの作り方をまとめた本です。"
    fill_in "著者", with: "エレン"
    click_on "登録する"

    assert_text "新しい本を登録しました。"

    assert_text "おいしいクレープレシピ"
    assert_text "色々な創作クレープの作り方をまとめた本です。"
    assert_text "エレン"
  end

  test "showing a Book" do
    visit book_path(books(:wagashi))

    assert_text "日本和菓子食べ歩き"
    assert_text "全国各地の和菓子を素敵な風景と一緒に楽しめる本です。"
    assert_text "デイヴ"
  end

  test "updating a Book" do
    visit edit_book_path(books(:wagashi))

    fill_in "タイトル", with: "日本和菓子食べ歩き増訂版"
    fill_in "メモ", with: "今までの内容に加えて、家でも作れる簡単和菓子レシピなどを収録。"
    fill_in "著者", with: "デイヴ、エレン"
    click_on "更新する"

    assert_text "本を更新しました。"

    assert_text "日本和菓子食べ歩き増訂版"
    assert_text "今までの内容に加えて、家でも作れる簡単和菓子レシピなどを収録。"
    assert_text "デイヴ、エレン"
  end

  test "destroying a Book" do
    visit books_url

    assert_text "日本和菓子食べ歩き"

    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "本を削除しました。"
    assert_no_text "日本和菓子食べ歩き"
  end
end
