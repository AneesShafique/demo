class StripeService
  def self.create_customer(stripeemail, stripetoken)
    customer = Stripe::Customer.create(
      email: stripeemail,
      source: stripetoken
    )
    customer
  end

  def self.create_charge(cart, final_amount, charge_metadata, id)
    Stripe::Charge.create(
      customer: id,
      amount: final_amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
      metadata: charge_metadata
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to cart_path(cart)
  end
end
