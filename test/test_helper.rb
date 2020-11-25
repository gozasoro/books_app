# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as_alice
    visit new_user_session_url
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  def select_date(column_name, date_string)
    year, month, day = date_string.split("-")
    select year, from: "report_#{column_name}_1i"
    select month, from: "report_#{column_name}_2i"
    select day, from: "report_#{column_name}_3i"
  end
end
