require 'test_helper'

class Api::V1::SeatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_seat = api_v1_seats(:one)
  end

  test "should get index" do
    get api_v1_seats_url, as: :json
    assert_response :success
  end

  test "should create api_v1_seat" do
    assert_difference('Api::V1::Seat.count') do
      post api_v1_seats_url, params: { api_v1_seat: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_v1_seat" do
    get api_v1_seat_url(@api_v1_seat), as: :json
    assert_response :success
  end

  test "should update api_v1_seat" do
    patch api_v1_seat_url(@api_v1_seat), params: { api_v1_seat: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_v1_seat" do
    assert_difference('Api::V1::Seat.count', -1) do
      delete api_v1_seat_url(@api_v1_seat), as: :json
    end

    assert_response 204
  end
end
