class OrdersController < ApplicationController
  def new
    @item = Item.find(params[:id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:id])
      render :new
    end
  end

  private

  def order_params
    params.permit(
      :post_code, :prefecture_id, :city, :address, :apartment, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:id])
  end
end
