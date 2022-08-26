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

    find("#any_login_form").click
    select(@user.email, from: 'selected_id')

    visit "/about"

    assert_text("This is secret page available only for logged in users")
  end
end
