class Api::V1::OrdersController < ApplicationController

  skip_before_action :verify_authenticity_token

  # GET /api/v1/orders
  def index 
    @orders = Order.all
    render json: @orders
  end

  # GET /api/v1/orders/:id
  def show
    @order = Order.find(params[:id])
    render json: @order
  rescue ActiveRecord::RecordNotFound => e
    logger.error e.message
    render json: { error: "Order not found" }, status: :not_found
  end

  # POST /api/v1/orders
  def create 
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/orders/:id
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/orders/:id
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    render json: { message: "Order deleted successfully" }, status: :ok
  end

  # Custom Member Action: POST /api/v1/orders/:id/process_tax
  def process_tax
    @order = Order.find(params[:id])
    
    tax_rate = 0.15 
    tax_amount = @order.total_price * tax_rate
    final_price_with_tax = @order.total_price + tax_amount

    render json: {
      order_id: @order.id,
      customer_name: @order.customer_name,
      original_price: @order.total_price,
      tax_applied: tax_amount,
      total_with_tax: final_price_with_tax,
      status: "Tax processed successfully"
    }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Order not found" }, status: :not_found
  end

  # Custom Collection Action: GET /api/v1/orders/pending_deliveries
  def pending_deliveries
    @orders = Order.where(order_type: "delivery")
    render json: @orders, status: :ok
  end

  private
  
  def order_params
    params.require(:order).permit(:customer_name, :order_type, :total_price, menu_item_ids: [])
  end
end