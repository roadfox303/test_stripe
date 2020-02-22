class ChargesController < ApplicationController
  def new
  end

  def create
  # Amount in cents
  product = Stripe::Product.create({
    name: '商品の名前',# 商品の名前
    type: 'service',# タイプserviceとgoodがあるそうな
  })
  plan = Stripe::Plan.create({
    product: 'prod_CbvTFuXWh7BPJH',# Productを作る場合はIDを指定する
    nickname: 'プランの名前',# 名前
    amount: 1000,# 値段
    currency: 'jpy',# 通貨
    interval: 'month',# 月額課金
  })
  
  @amount = 500

  customer = Stripe::Customer.create({
    email: params[:stripeEmail],
    source: params[:stripeToken],
  })

  charge = Stripe::Charge.create({
    customer: customer.id,
    amount: @amount,
    description: 'Rails Stripe customer',
    currency: 'usd',
  })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
