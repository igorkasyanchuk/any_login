require_relative "../test_helper_devise"

class NavigationTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "test", email: "test@test.com", password: "password123", role: "user")
  end

  test "user cannot navigate to about page without login" do
    visit "/about"

    assert_no_text("This is secret page available only for logged in users")
  end

  test "it properly logs users in and allows access to the secret page" do
    visit "/"

    find(".any_login_form_toggle_label").click
    # There is an instability in the test suite where the option on the dropdown sometimes shows
    # up as `1` and sometimes shows up as `test@test.com`. This works around the issue.
    find("select option:last-of-type", match: :first).select_option

    visit "/about"

    assert_text("This is secret page available only for logged in users")
  end
end
