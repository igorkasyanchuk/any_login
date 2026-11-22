require_relative "../test_helper_devise"

module AnyLogin
  class HelpersTest < ActionView::TestCase
    include AnyLogin::Helpers

    test "any_login_id_input renders the ID field on the first call" do
      assert_dom_equal(
        '<input type="text" name="id" id="any_login_id_input" value="" placeholder="ID" required="required" />',
        any_login_id_input
      )
    end
  end
end
