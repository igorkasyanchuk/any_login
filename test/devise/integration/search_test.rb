require_relative "../test_helper_devise"

class SearchTest < ActionDispatch::IntegrationTest
  setup do
    @previous_search_by = AnyLogin.search_by
    @previous_name_method = AnyLogin.name_method
    AnyLogin.name_method = proc { |user| [user.email, user.id] }
    @alice = User.create!(name: "Alice Smith", email: "alice@example.com", password: "password123", role: "user")
    User.create!(name: "Bob Jones", email: "bob@sample.org", password: "password123", role: "user")
  end

  teardown do
    AnyLogin.search_by = @previous_search_by
    AnyLogin.name_method = @previous_name_method
  end

  test "returns matching users as JSON" do
    AnyLogin.search_by = [:email, :name]

    get "/any_login/any_login/search", params: { q: "smith" }

    assert_response :success
    assert_equal [{ "id" => @alice.id, "label" => "alice@example.com" }], response.parsed_body
  end

  test "returns nothing for a blank query" do
    AnyLogin.search_by = [:email]

    get "/any_login/any_login/search", params: { q: " " }

    assert_equal [], response.parsed_body
  end

  test "is not found when search is disabled" do
    AnyLogin.search_by = nil

    get "/any_login/any_login/search", params: { q: "alice" }

    assert_response :not_found
  end

  test "is forbidden when access is denied" do
    AnyLogin.search_by = [:email]
    previous_proc = AnyLogin.verify_access_proc
    AnyLogin.verify_access_proc = proc { false }

    get "/any_login/any_login/search", params: { q: "alice" }

    assert_response :forbidden
  ensure
    AnyLogin.verify_access_proc = previous_proc
  end

  test "signs in a user found by typing" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    fill_in "any_login_search", with: "smith"
    assert_selector "#selected_id option", text: "alice@example.com"
    assert_no_selector "#selected_id option", text: "bob@sample.org"
    find("#selected_id").select("alice@example.com")

    visit "/about"

    assert_text("This is secret page available only for logged in users")
  end
end
