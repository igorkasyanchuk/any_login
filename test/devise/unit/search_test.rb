require_relative "../test_helper_devise"

module AnyLogin
  class SearchTest < ActiveSupport::TestCase
    setup do
      @previous_search_by = AnyLogin.search_by
      @previous_limit = AnyLogin.limit
      @alice = ::User.create!(name: "Alice Smith", email: "alice@example.com", password: "password123")
      @bob = ::User.create!(name: "Bob Jones", email: "bob@sample.org", password: "password123")
    end

    teardown do
      AnyLogin.search_by = @previous_search_by
      AnyLogin.limit = @previous_limit
    end

    test "search is disabled by default" do
      AnyLogin.search_by = nil

      assert_equal false, AnyLogin.search_enabled?
    end

    test "matches any of the given attributes, ignoring case" do
      AnyLogin.search_by = [:email, :name]

      assert_equal [@alice], AnyLogin.search("SMITH")
      assert_equal [@bob], AnyLogin.search("sample")
    end

    test "treats LIKE wildcards in the query literally" do
      AnyLogin.search_by = [:email]
      underscored = ::User.create!(name: "John", email: "john_doe@example.com", password: "password123")
      ::User.create!(name: "Johnx", email: "johnxdoe@example.com", password: "password123")

      assert_equal [underscored], AnyLogin.search("john_doe")
      assert_empty AnyLogin.search("%")
    end

    test "uses a custom proc" do
      AnyLogin.search_by = proc { |query| ::User.where(name: query) }

      assert_equal [@bob], AnyLogin.search("Bob Jones")
    end

    test "respects the limit" do
      AnyLogin.search_by = [:email]
      AnyLogin.limit = 1

      assert_equal 1, AnyLogin.search("e").size
    end
  end
end
