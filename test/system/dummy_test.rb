require "application_system_test_case"

class DummyTest < ApplicationSystemTestCase
  test "visiting home page" do
    visit "/"
    assert_text "Rails"
  end
end