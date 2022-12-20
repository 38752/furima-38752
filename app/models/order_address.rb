class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id,
                :post_code, :prefecture_id, :city, :address, :apartment, :phone_number, :order_id,
                :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :city
    validates :address
    validates :token
  end
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/.freeze, message: "is invalid. Include hyphen(-)" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/.freeze, message: "is invalid." }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, apartment: apartment,
      phone_number: phone_number, order_id: order.id
    )
  end
end
