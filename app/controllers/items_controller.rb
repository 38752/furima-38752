class ItemsController < ApplicationController
  # before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, except: [:index]

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

  def item_params
    params.require(:item).permit(
      :image, :name, :detail, :category_id, :condition_id, :delivery_charge_by_id, :prefecture_id, :days_to_post_id, :price
    ).merge(user_id: current_user.id)
  end
end
