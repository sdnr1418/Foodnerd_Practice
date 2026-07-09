class Api::V1::CustomersController < ApplicationController
  # Skip CSRF verification since we are testing via API/curl clients
  skip_before_action :verify_authenticity_token
  before_action :set_customer, only: [:update]
  before_action :authorize_manager!, only: [:update]

  # POST /api/v1/customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: {
        message: "Customer created successfully",
        customer: @customer
      }, status: :created # Status 201
    else
      render json: {
        errors: @customer.errors.full_messages
      }, status: :unprocessable_entity # Status 422
    end
  end

  # PATCH/PUT /api/v1/customers/:id
  def update
    if @customer.update(customer_params)
      render json: {
        message: "Customer updated successfully",
        customer: @customer
      }, status: :ok # Status 200
    else
      render json: {
        errors: @customer.errors.full_messages
      }, status: :unprocessable_entity # Status 422
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Customer not found" }, status: :not_found
  end

  # Strong Parameters encapsulation
  def customer_params
    params.require(:customer).permit(:name, :email, :phone, :profile_picture_url)
  end
end