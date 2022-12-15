class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end 
  end

  def item_params
    params[:item][:price] = params[:item][:price].tr('０-９','0-9').to_i
    params.require(:item).permit(
      :image, :name, :detail, :category_id, :condition_id, :delivery_charge_by_id, :prefecture_id, :days_to_post_id, :price
    ).merge(user_id: current_user.id)
  end

end
