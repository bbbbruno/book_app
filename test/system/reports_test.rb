# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user.create_profile
    login_as @user
  end

  test "show listing reports" do
    visit reports_path
    assert_selector "h1", text: I18n.t("reports.index.title")
  end

  test "create report" do
    visit new_report_path

    fill_in "report_title", with: "ドラゴンを倒した"
    fill_in "report_date", with: Date.current
    fill_in "report_content", with: "強かったけど倒せた\nこれで世界は平和だ\nエヘヘ"
    find('input[type="submit"]').click

    assert_text I18n.t("flash.new")
  end

  test "show report" do
    report = reports(:one)
    visit report_path(id: report.id)

    assert_selector "span", text: I18n.l(report.date) + " " + I18n.t("reports.show.title")
  end

  test "update report" do
    report = reports(:one)
    visit edit_report_path(id: report.id)

    fill_in "report_title", with: "鏡の中のマリオネット"
    fill_in "report_date", with: 2.days.ago
    fill_in "report_content", with: "これは名曲だ"
    find('input[type="submit"]').click

    assert_text I18n.t("flash.update")
  end

  test "destroy report" do
    visit reports_path
    page.accept_confirm do
      click_on I18n.t("dictionary.button.destroy"), match: :first
    end

    assert_text I18n.t("flash.destroy")
  end
end
