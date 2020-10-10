# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  def setup
    visit new_user_session_url
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "日報一覧"

    columns = page.find("tbody").all("tr")[0].all("td")
    assert columns[0].has_text?("2020-10-08")
    assert columns[1].has_text?("Report Title")
    assert columns[2].has_text?("Alice")
  end

  test "creating a Report" do
    visit reports_url
    click_on "新しい日報を作成"

    select "2020", from: "report_written_at_1i"
    select "10", from: "report_written_at_2i"
    select "10", from: "report_written_at_3i"
    fill_in "タイトル", with: "New Title"
    fill_in "内容", with: "New Body"
    click_on "登録する"

    assert_text "日報を作成しました。"

    rows = page.find("tbody").all("tr")
    assert rows[0].all("td")[1].has_text?("2020-10-10")
    assert rows[1].all("td")[1].has_text?("New Title")
    assert rows[2].all("td")[1].has_text?("New Body")
    assert rows[3].all("td")[1].has_text?("Alice")
  end

  test "showing a Report" do
    visit reports_url
    click_on "表示", match: :first

    rows = page.find("tbody").all("tr")
    assert rows[0].all("td")[1].has_text?("2020-10-08")
    assert rows[1].all("td")[1].has_text?("Report Title")
    assert rows[2].all("td")[1].has_text?("Report Body")
    assert rows[3].all("td")[1].has_text?("Alice")
  end

  test "updating a Report" do
    visit reports_url
    click_on "編集", match: :first

    select "2020", from: "report_written_at_1i"
    select "10", from: "report_written_at_2i"
    select "10", from: "report_written_at_3i"
    fill_in "タイトル", with: "New Title"
    fill_in "内容", with: "New Body"
    click_on "更新する"

    assert_text "日報を更新しました。"

    rows = page.find("tbody").all("tr")
    assert rows[0].all("td")[1].has_text?("2020-10-10")
    assert rows[1].all("td")[1].has_text?("New Title")
    assert rows[2].all("td")[1].has_text?("New Body")
    assert rows[3].all("td")[1].has_text?("Alice")
  end

  test "destroying a Report" do
    visit reports_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "日報を削除しました。"
    within(:css, "table") do
      assert_no_text "2020-10-08"
      assert_no_text "Report Title"
      assert_no_text "Alice"
    end
  end
end
