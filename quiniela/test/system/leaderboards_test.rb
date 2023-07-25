require "application_system_test_case"

class LeaderboardsTest < ApplicationSystemTestCase
  setup do
    @leaderboard = leaderboards(:one)
  end

  test "visiting the index" do
    visit leaderboards_url
    assert_selector "h1", text: "Leaderboards"
  end

  test "should create leaderboard" do
    visit leaderboards_url
    click_on "New leaderboard"

    click_on "Create Leaderboard"

    assert_text "Leaderboard was successfully created"
    click_on "Back"
  end

  test "should update Leaderboard" do
    visit leaderboard_url(@leaderboard)
    click_on "Edit this leaderboard", match: :first

    click_on "Update Leaderboard"

    assert_text "Leaderboard was successfully updated"
    click_on "Back"
  end

  test "should destroy Leaderboard" do
    visit leaderboard_url(@leaderboard)
    click_on "Destroy this leaderboard", match: :first

    assert_text "Leaderboard was successfully destroyed"
  end
end
