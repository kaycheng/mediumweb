class UsersController < ApplicationController
  
  def pricing
  end

  def payment
    @fee = ENV["price_#{params[:type]}"]
    @payment_type = (params[:type] == 'vip') ? 'VIP Member' : 'Platinum Member'
    @token = gateway.client_token.generate
  end

  def pay
    fee = ENV["price_#{params[:type]}"]
    nonce = params[:payment_nonce]

    result = gateway.transaction.sale(
      amount: fee,
      payment_method_nonce: nonce,
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      current_user.send("#{params[:type]}_user!") # meta programming
      redirect_to root_path, notice: "Paid successfully!"
    else
      redirect_to root_path, notice: "Something is in error!"
    end
  end

  private

  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["braintree_merchant_id"],
      public_key: ENV["braintree_public_key"],
      private_key: ENV["braintree_private_key"],
      )
  end
end