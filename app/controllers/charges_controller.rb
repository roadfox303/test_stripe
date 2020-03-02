class ChargesController < ApplicationController
  def new
  end

  def create
  # Amount in cents

  @amount = 500

  customer = Stripe::Customer.create({
    email: params[:stripeEmail],
    source: params[:stripeToken],
  })
  order = Stripe::Order.create({
    currency: 'jpy',
    email: customer.email,
    items: [
        {
            type: 'sku',
            parent: 'sku_Gpn8Qa6n6FOi9L',
            quantity: 1,
        },
    ]
  })
  binding.pry

  # charge = Stripe::Charge.create({
  #   customer: customer.id,
  #   amount: @amount,
  #   description: 'Rails Stripe customer',
  #   currency: 'usd',
  # })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
