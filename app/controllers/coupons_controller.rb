class CouponsController < ApplicationController
  def new
    # This instantiates an empty object that we pass down to the form
    @coupon = Coupon.new 
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to coupons_path, notice: "Coupon created successfully!"
    else
      # If validations fail, re-render the 'new' form with the error-loaded @coupon object
      render :new, status: :unprocessable_entity
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount_percentage, :expiry_date)
  end
end