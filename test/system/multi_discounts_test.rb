require "application_system_test_case"

class MultiDiscountsTest < ApplicationSystemTestCase
  setup do
    @multi_discount = multi_discounts(:one)
  end

  test "visiting the index" do
    visit multi_discounts_url
    assert_selector "h1", text: "Multi discounts"
  end

  test "should create multi discount" do
    visit multi_discounts_url
    click_on "New multi discount"

    fill_in "Discount amount", with: @multi_discount.discount_amount
    click_on "Create Multi discount"

    assert_text "Multi discount was successfully created"
    click_on "Back"
  end

  test "should update Multi discount" do
    visit multi_discount_url(@multi_discount)
    click_on "Edit this multi discount", match: :first

    fill_in "Discount amount", with: @multi_discount.discount_amount
    click_on "Update Multi discount"

    assert_text "Multi discount was successfully updated"
    click_on "Back"
  end

  test "should destroy Multi discount" do
    visit multi_discount_url(@multi_discount)
    click_on "Destroy this multi discount", match: :first

    assert_text "Multi discount was successfully destroyed"
  end
end
