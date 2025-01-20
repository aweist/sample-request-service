class SampleRequestsController < ApplicationController
  before_action :set_sample_request, only: %i[ show update destroy ]

  # GET /sample_requests
  def index
    @sample_requests = SampleRequest.all

    render json: @sample_requests
  end

  # GET /sample_requests/1
  def show
    render json: @sample_request
  end

  # POST /sample_requests
  def create
    @sample_request = SampleRequest.new(sample_request_params)

    if @sample_request.save
      render json: @sample_request, status: :created, location: @sample_request
    else
      render json: @sample_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sample_requests/1
  def update
    if @sample_request.update(sample_request_params)
      render json: @sample_request
    else
      render json: @sample_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sample_requests/1
  def destroy
    @sample_request.destroy!
  end

  def approve
    @sample_request = SampleRequest.find(params[:id])

    if @sample_request.update(status: "approved")
      render json: @sample_request, status: :ok
    else
      render json: @sample_request.errors, status: :unprocessable_entity
    end
  end

  def reject
    @sample_request = SampleRequest.find(params[:id])

    if @sample_request.update(status: "rejected")
      render json: @sample_request, status: :ok
    else
      render json: @sample_request.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sample_request
      @sample_request = SampleRequest.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def sample_request_params
      params.expect(sample_request: [ :first_name, :last_name, :email_address, :street_address, :city, :state, :postal_code, :org, :org_name, :org_size, :approved_at, :approved_by ])
    end
end
