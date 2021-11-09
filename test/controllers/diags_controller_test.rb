require "test_helper"

class DiagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diag = diags(:one)
  end

  test "should get index" do
    get diags_url
    assert_response :success
  end

  test "should get new" do
    get new_diag_url
    assert_response :success
  end

  test "should create diag" do
    assert_difference('Diag.count') do
      post diags_url, params: { diag: { lighthouse: @diag.lighthouse, url: @diag.url, views: @diag.views, websitecarbon: @diag.websitecarbon } }
    end

    assert_redirected_to diag_url(Diag.last)
  end

  test "should show diag" do
    get diag_url(@diag)
    assert_response :success
  end

  test "should get edit" do
    get edit_diag_url(@diag)
    assert_response :success
  end

  test "should update diag" do
    patch diag_url(@diag), params: { diag: { lighthouse: @diag.lighthouse, url: @diag.url, views: @diag.views, websitecarbon: @diag.websitecarbon } }
    assert_redirected_to diag_url(@diag)
  end

  test "should destroy diag" do
    assert_difference('Diag.count', -1) do
      delete diag_url(@diag)
    end

    assert_redirected_to diags_url
  end
end
