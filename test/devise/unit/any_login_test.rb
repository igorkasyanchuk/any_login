require_relative "../test_helper_devise"

class AnyLoginTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, AnyLogin
  end
end
