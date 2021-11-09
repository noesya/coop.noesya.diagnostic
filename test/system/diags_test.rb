require "application_system_test_case"

class DiagsTest < ApplicationSystemTestCase
  setup do
    @diag = diags(:one)
  end

  test "visiting the index" do
    visit diags_url
    assert_selector "h1", text: "Diags"
  end

  test "creating a Diag" do
    visit diags_url
    click_on "New Diag"

    fill_in "Lighthouse", with: @diag.lighthouse
    fill_in "Url", with: @diag.url
    fill_in "Views", with: @diag.views
    fill_in "Websitecarbon", with: @diag.websitecarbon
    click_on "Create Diag"

    assert_text "Diag was successfully created"
    click_on "Back"
  end

  test "updating a Diag" do
    visit diags_url
    click_on "Edit", match: :first

    fill_in "Lighthouse", with: @diag.lighthouse
    fill_in "Url", with: @diag.url
    fill_in "Views", with: @diag.views
    fill_in "Websitecarbon", with: @diag.websitecarbon
    click_on "Update Diag"

    assert_text "Diag was successfully updated"
    click_on "Back"
  end

  test "destroying a Diag" do
    visit diags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Diag was successfully destroyed"
  end
end
