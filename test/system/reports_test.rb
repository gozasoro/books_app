# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  def setup
    login_as_alice
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "日報一覧"

    assert page.find(".reports-table .report-published_on").has_text?("2020-10-15")
    assert page.find(".reports-table .report-title").has_text?("ソフトクリーム")
    assert page.find(".reports-table .report-created_by").has_text?("Alice")
  end

  test "creating a Report" do
    visit reports_url
    click_on "新しい日報を作成"

    select_date("published_on", "2020-10-25")
    fill_in "タイトル", with: "今日もソフトクリーム"
    fill_in "内容", with: "めちゃうま！"
    click_on "登録する"

    assert_text "日報を作成しました。"

    assert page.find(".report-table .report-published_on").has_text?("2020-10-25")
    assert page.find(".report-table .report-title").has_text?("今日もソフトクリーム")
    assert page.find(".report-table .report-body").has_text?("めちゃうま！")
    assert page.find(".report-table .report-created_by").has_text?("Alice")
  end

  test "showing a Report" do
    visit report_path(reports(:one_day_report))

    assert page.find(".report-table .report-published_on").has_text?("2020-10-15")
    assert page.find(".report-table .report-title").has_text?("ソフトクリーム")
    assert page.find(".report-table .report-body").has_text?("おいしかった！")
    assert page.find(".report-table .report-created_by").has_text?("Alice")
  end

  test "updating a Report" do
    visit edit_report_path(reports(:one_day_report))

    select_date("published_on", "2020-10-25")
    fill_in "タイトル", with: "カフェでソフトクリーム"
    fill_in "内容", with: "とてもおいしかった！"
    click_on "更新する"

    assert_text "日報を更新しました。"

    assert page.find(".report-table .report-published_on").has_text?("2020-10-25")
    assert page.find(".report-table .report-title").has_text?("カフェでソフトクリーム")
    assert page.find(".report-table .report-body").has_text?("とてもおいしかった！")
    assert page.find(".report-table .report-created_by").has_text?("Alice")
  end

  test "destroying a Report" do
    visit reports_url

    assert_text "ソフトクリーム"

    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "日報を削除しました。"
    assert_no_text "ソフトクリーム"
  end
end
