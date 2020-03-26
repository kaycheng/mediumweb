class UsersController < ApplicationController
  
  def pricing
  end

  def payment
    @fee = ENV["price_#{params[:type]}"]
    @payment_type = (params[:type] == 'vip') ? 'VIP Member' : 'Platinum Member'
  end

end