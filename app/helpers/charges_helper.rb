module ChargesHelper
  def discount(discount)
    if discount.nil?
      flash[:error] = 'Coupon code is not valid or expired.'
      redirect_to cart_path(@cart)
    else
      @discount_amount = @amount * discount
      @final_amount = @amount - @discount_amount.to_i
    end
  end

end
