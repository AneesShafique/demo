class ChargesController < ApplicationController
  include CurrentCart
  include ChargesHelper
  before_action :set_cart
  before_action :set_amount
  before_action :getcode

  def create
    unless @code.blank?
      @discount = get_discount(@code)
      discount(@discount)
      charge_metadata = {
        coupon_code: @code,
        coupon_discount: (@discount * 100).to_s + '%',
      }
    end
    charge_metadata ||= {}
    customer = StripeService.create_customer(params[:stripeEmail], params[:stripeToken])
    StripeService.create_charge(@cart, @final_amount, charge_metadata, customer.id)
  end

  private

  COUPONS = {
    'DEVSINC' => 0.3,
    'PAKARMY' => 0.5
  }

  def get_discount(code)
    # Normalize user input
    code = code.gsub(/\s+/, '')
    code = code.upcase
    COUPONS[code]
  end

  def set_amount
    @amount = @cart.total_price
    @final_amount = @amount
  end

  def getcode
    @code = params[:couponCode]
  end
end
