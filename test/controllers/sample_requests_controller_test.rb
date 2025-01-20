require "test_helper"

class SampleRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sample_request = sample_requests(:one)
  end

  test "should get index" do
    get sample_requests_url, as: :json
    assert_response :success
  end

  test "should create sample_request" do
    assert_difference("SampleRequest.count") do
      post sample_requests_url, params: { sample_request: { city: @sample_request.city, email_address: @sample_request.email_address, first_name: @sample_request.first_name, last_name: @sample_request.last_name, org: @sample_request.org, org_name: @sample_request.org_name, org_size: @sample_request.org_size, postal_code: @sample_request.postal_code, state: @sample_request.state, street_address: @sample_request.street_address, status: @sample_request.status } }, as: :json
    end

    assert_response :created
  end

  test "should show sample_request" do
    get sample_request_url(@sample_request), as: :json
    assert_response :success
  end

  test "should update sample_request" do
    patch sample_request_url(@sample_request), params: { sample_request: { city: @sample_request.city, email_address: @sample_request.email_address, first_name: @sample_request.first_name, last_name: @sample_request.last_name, org: @sample_request.org, org_name: @sample_request.org_name, org_size: @sample_request.org_size, postal_code: @sample_request.postal_code, state: @sample_request.state, street_address: @sample_request.street_address, status: @sample_request.status } }, as: :json
    assert_response :success
  end

  test "should destroy sample_request" do
    assert_difference("SampleRequest.count", -1) do
      delete sample_request_url(@sample_request), as: :json
    end

    assert_response :no_content
  end

  test "should approve sample_request" do
    post approve_sample_request_url(@sample_request), as: :json
    assert_response :success
    @sample_request.reload
    assert_equal "approved", @sample_request.status
  end

  test "should reject sample_request" do
    post reject_sample_request_url(@sample_request), as: :json
    assert_response :success
    @sample_request.reload
    assert_equal "rejected", @sample_request.status
  end
end
