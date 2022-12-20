class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user != Item.find(params[:id]).user && Order.where(item_id: params[:id]).empty?
      @item = Item.find(params[:id])
      @order_address = OrderAddress.new
    else
      redirect_to root_path
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :post_code, :prefecture_id, :city, :address, :apartment, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
