require "test_helper"

class SampleRequestTest < ActiveSupport::TestCase
  test "should not save sample request without email" do
    sample_request = SampleRequest.new
    assert_not sample_request.save, "Saved the sample request without an email"
  end

  test "should not save sample request with invalid email" do
    sample_request = SampleRequest.new(email_address: "invalid_email")
    assert_not sample_request.save, "Saved the sample request with an invalid email"
  end

  test "should save sample request with valid email" do
    sample_request = SampleRequest.new(
      email_address: "valid@example.com",
      first_name: "John",
      last_name: "Doe",
      street_address: "123 Main St",
      city: "Anytown",
      state: "CA",
      postal_code: "12345"
    )
    assert sample_request.save, "Failed to save the sample request with a valid email"
  end

  test "should auto-approve sample request if criteria met" do
    sample_request = SampleRequest.new(
      email_address: "unique@example.com",
      first_name: "Jane",
      last_name: "Doe",
      street_address: "456 Elm St",
      city: "Othertown",
      state: "NY",
      postal_code: "67890",
      org_size: 5
    )
    sample_request.save
    assert_not_nil sample_request.approved_at, "Sample request was not auto-approved"
    assert_equal 0, sample_request.approved_by, "Sample request was not approved by the system user"
  end

  test "should not auto-approve sample request if org size is 10 or more" do
    sample_request = SampleRequest.new(
      email_address: "unique2@example.com",
      first_name: "Alice",
      last_name: "Smith",
      street_address: "789 Oak St",
      city: "Sometown",
      state: "TX",
      postal_code: "54321",
      org_size: 10
    )
    sample_request.save
    assert_nil sample_request.approved_at, "Sample request was incorrectly auto-approved"
  end

  test "should not auto-approve sample request if email already exists" do
    existing_request = SampleRequest.create(
      email_address: "existing@example.com",
      first_name: "Bob",
      last_name: "Brown",
      street_address: "101 Pine St",
      city: "Anycity",
      state: "FL",
      postal_code: "11223",
      org_size: 5
    )
    sample_request = SampleRequest.new(
      email_address: "existing@example.com",
      first_name: "Charlie",
      last_name: "Davis",
      street_address: "202 Maple St",
      city: "Anycity",
      state: "FL",
      postal_code: "11223",
      org_size: 5
    )
    sample_request.save
    assert_nil sample_request.approved_at, "Sample request was incorrectly auto-approved"
  end

  test "should not auto-approve sample request if address already exists" do
    existing_request = SampleRequest.create(
      email_address: "unique3@example.com",
      first_name: "Eve",
      last_name: "White",
      street_address: "303 Birch St",
      city: "Anycity",
      state: "FL",
      postal_code: "11223",
      org_size: 5
    )
    sample_request = SampleRequest.new(
      email_address: "unique4@example.com",
      first_name: "Frank",
      last_name: "Green",
      street_address: "303 Birch St",
      city: "Anycity",
      state: "FL",
      postal_code: "11223",
      org_size: 5
    )
    sample_request.save
    assert_nil sample_request.approved_at, "Sample request was incorrectly auto-approved"
  end
end
