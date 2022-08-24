require "test_helper_devise"

module AnyLogin
  class CollectionTest < ActiveSupport::TestCase
    FakeUser = Struct.new(:id, :email)

    test "single collection should return false with the grouped?" do
      single = [
        FakeUser.new(1, "1@example.com"),
        FakeUser.new(2, "2@example.com")
      ]
      collection = AnyLogin::Collection.new(single)

      assert_equal false, collection.grouped?
    end

    test "single collection should returns an Array" do
      begin
        prev = AnyLogin.name_method

        single = [
          FakeUser.new(1, "1@example.com"),
          FakeUser.new(2, "2@example.com")
        ]
        collection = AnyLogin::Collection.new(single)

        AnyLogin.name_method = :email
        assert_equal ["1@example.com", "2@example.com"], collection.to_a

        AnyLogin.name_method = ->(e) { e.id }
        assert_equal [1, 2], collection.to_a
      rescue
        AnyLogin.name_method = prev
      end
    end

    test "grouped collection should return true with the grouped?" do
      grouped = [
        ["admin", [FakeUser.new(1, "1@example.com"), FakeUser.new(2, "2@example.com")]],
        ["user",  [FakeUser.new(3, "3@example.com"), FakeUser.new(4, "4@example.com")]],
      ]
      collection = AnyLogin::Collection.new(grouped)

      assert_equal true, collection.grouped?
    end

    test "grouped collection should returns an Array" do
      begin
        prev = AnyLogin.name_method

        grouped = [
          ["admin", [FakeUser.new(1, "1@example.com"), FakeUser.new(2, "2@example.com")]],
          ["user",  [FakeUser.new(3, "3@example.com"), FakeUser.new(4, "4@example.com")]],
        ]
        collection = AnyLogin::Collection.new(grouped)

        AnyLogin.name_method = :email
        expected = [
          ["admin", ["1@example.com", "2@example.com"]],
          ["user", ["3@example.com", "4@example.com"]]
        ]
        assert_equal expected, collection.to_a

        AnyLogin.name_method = ->(e) { e.id }
        expected = [
          ["admin", [1, 2]],
          ["user", [3, 4]]
        ]
        assert_equal expected, collection.to_a
      rescue
        AnyLogin.name_method = prev
      end
    end
  end
end
