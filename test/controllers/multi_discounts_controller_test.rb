require "test_helper"

class MultiDiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multi_discount = multi_discounts(:one)
  end

  test "should get index" do
    get multi_discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_multi_discount_url
    assert_response :success
  end

  test "should create multi_discount" do
    assert_difference("MultiDiscount.count") do
      post multi_discounts_url, params: { multi_discount: { discount_amount: @multi_discount.discount_amount } }
    end

    assert_redirected_to multi_discount_url(MultiDiscount.last)
  end

  test "should show multi_discount" do
    get multi_discount_url(@multi_discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_multi_discount_url(@multi_discount)
    assert_response :success
  end

  test "should update multi_discount" do
    patch multi_discount_url(@multi_discount), params: { multi_discount: { discount_amount: @multi_discount.discount_amount } }
    assert_redirected_to multi_discount_url(@multi_discount)
  end

  test "should destroy multi_discount" do
    assert_difference("MultiDiscount.count", -1) do
      delete multi_discount_url(@multi_discount)
    end

    assert_redirected_to multi_discounts_url
  end
end
