require_relative "../test_helper_devise"

class SearchTest < ActionDispatch::IntegrationTest
  setup do
    @previous_search_by = AnyLogin.search_by
    @previous_name_method = AnyLogin.name_method
    @previous_collection_method = AnyLogin.collection_method
    AnyLogin.name_method = proc { |user| [user.email, user.id] }
    @alice = User.create!(name: "Alice Smith", email: "alice@example.com", password: "password123", role: "user")
    User.create!(name: "Bob Jones", email: "bob@sample.org", password: "password123", role: "user")
  end

  teardown do
    AnyLogin.search_by = @previous_search_by
    AnyLogin.name_method = @previous_name_method
    AnyLogin.collection_method = @previous_collection_method
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

  test "signs in a user picked from the search dropdown" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    fill_in "any_login_search", with: "smith"
    assert_selector "#any_login_search[aria-busy=false]"
    assert_selector "#any_login_search_results [role=option]", text: "alice@example.com"
    assert_no_selector "#any_login_search_results [role=option]", text: "bob@sample.org"
    find("#any_login_search_results [role=option]", text: "alice@example.com").click
    assert_selector "#back_to_previous_id", visible: :all

    visit "/about"

    assert_text("This is secret page available only for logged in users")
  end

  test "picks a search result with the keyboard" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    fill_in "any_login_search", with: "example"
    assert_selector "#any_login_search[aria-busy=false]"
    assert_selector "#any_login_search_results [role=option][aria-selected=true]", text: "alice@example.com"
    find("#any_login_search").send_keys(:enter)
    assert_selector "#back_to_previous_id", visible: :all

    visit "/about"

    assert_text("This is secret page available only for logged in users")
  end

  test "opens the dropdown above the search field when the box is at the bottom" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    fill_in "any_login_search", with: "smith"
    assert_selector "#any_login_search[aria-busy=false]"
    assert_selector "#any_login_search_results [role=option]", text: "alice@example.com"

    list_bottom, input_top = evaluate_script(<<~JS)
      [document.getElementById("any_login_search_results").getBoundingClientRect().bottom,
       document.getElementById("any_login_search").getBoundingClientRect().top]
    JS
    assert_operator list_bottom, :<=, input_top
  end

  test "shows a message when nothing matches" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    fill_in "any_login_search", with: "nobody"
    assert_selector "#any_login_search[aria-busy=false]"

    assert_selector "#any_login_search_results li", text: "No matches"
  end

  test "replaces the user select with the search field" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click

    assert_selector "#any_login_search"
    assert_no_selector "#selected_id"
  end

  test "lists the default users when the empty search field is focused" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    find("#any_login_search").click

    assert_selector "#any_login_search_results [role=option]", text: "alice@example.com"
    assert_selector "#any_login_search_results [role=option]", text: "bob@sample.org"
    assert_no_selector "#any_login_search_results [aria-selected=true]"
    find("#any_login_search_results [role=option]", text: "bob@sample.org").click
    assert_selector "#back_to_previous_id", visible: :all

    visit "/about"

    assert_text("This is secret page available only for logged in users")
  end

  test "shows group headers for a grouped collection" do
    AnyLogin.search_by = [:email, :name]
    AnyLogin.collection_method = :groped_collection
    User.create!(name: "Carol Admin", email: "carol@example.com", password: "password123", role: "admin")

    visit "/"
    find("#any_login_form_toggle_label").click
    find("#any_login_search").click

    assert_selector "#any_login_search_results li.any_login_search_group", text: /admin/i
    assert_selector "#any_login_search_results li.any_login_search_group", text: /user/i
    assert_selector "#any_login_search_results [role=option]", count: 3
  end

  test "arrow up from the default list highlights the last user" do
    AnyLogin.search_by = [:email, :name]

    visit "/"
    find("#any_login_form_toggle_label").click
    find("#any_login_search").click
    assert_selector "#any_login_search_results [role=option]", count: 2
    find("#any_login_search").send_keys(:up)

    assert_selector "#any_login_search_results [role=option]:last-child[aria-selected=true]"
  end
end
